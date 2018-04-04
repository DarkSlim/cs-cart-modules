<?php
/***************************************************************************
* @developer Kaminsky Edward, MakeShop.pro
* @module ms_cryptonator
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

use Tygh\Registry;
use Tygh\Payments\Processors\Cryptonator\MerchantAPI;

if (defined('PAYMENT_NOTIFICATION')) {

	if (isset($_REQUEST['ordernumber'])) {
        list($order_id) = explode('_', $_REQUEST['ordernumber']);

    } elseif (isset($_REQUEST['orderNumber'])) {
        list($order_id) = explode('_', $_REQUEST['orderNumber']);

    } elseif (isset($_REQUEST['merchant_order_id'])) {
        list($order_id) = explode('_', $_REQUEST['merchant_order_id']);

    } elseif (isset($_REQUEST['order_id'])) {
        list($order_id) = explode('_', $_REQUEST['order_id']);

    } else {
        $order_id = 0;
    }

    $payment_id = db_get_field("SELECT payment_id FROM ?:orders WHERE order_id = ?i", $order_id);
    $processor_data = fn_get_processor_data($payment_id);
    $merchant_id = $processor_data['processor_params']['merchant_id'];

    if (!empty($processor_data['processor_params']['logging']) && $processor_data['processor_params']['logging'] == 'Y') {
        fn_ms_cryptonator_log_write($mode, 'cryptonator_request.log');
        fn_ms_cryptonator_log_write($_REQUEST, 'cryptonator_request.log');
    }

    if ($mode == 'ok') {

        if (fn_check_payment_script('cryptonator.php', $order_id)) {

            $times = 0;
            while ($times <= CRYPTONATOR_MAX_AWAITING_TIME) {

                $_order_id = db_get_field("SELECT order_id FROM ?:order_data WHERE order_id = ?i AND type = 'S'", $order_id);
                if (empty($_order_id)) {
                    break;
                }

                sleep(1);
                $times++;
            }

            $order_status = db_get_field("SELECT status FROM ?:orders WHERE order_id = ?i", $order_id);

            if ($order_status == STATUS_INCOMPLETED_ORDER) {
                fn_change_order_status($order_id, 'O');
            }

            fn_order_placement_routines('route', $order_id, false);
        }

    } elseif ($mode == 'error') {

        $pp_response['order_status'] = 'N';
        $pp_response["reason_text"] = __('text_transaction_declined');

        if (fn_check_payment_script('cryptonator.php', $order_id)) {
            fn_finish_payment($order_id, $pp_response, false);
        }

        fn_order_placement_routines('route', $order_id);

    } elseif ($mode == 'callback') {
        fn_ms_cryptonator_log_write("Invoice ".$_REQUEST['invoice_id'].": " . json_encode($_REQUEST, true), 'cryptonator_payment_callback.log');

        unset($_REQUEST['dispatch']);
        unset($_REQUEST['payment']);

        $code = 502;

        $cryptonator = new MerchantAPI( $processor_data['processor_params']['merchant_id'], $processor_data['processor_params']['secret'] );
        
        $hash_check = $cryptonator->checkAnswer($_REQUEST);

        if ($hash_check === true) {
            $invoice = $cryptonator->getInvoice($_REQUEST['invoice_id']);

            if( $_REQUEST['invoice_status'] == $invoice['status'] && $invoice['status'] == 'paid' ) {
                $order_status = 'P';
                $pp_response = array(
                    'order_status' => $order_status,
                    'cryptonator_invoice_id' => $_REQUEST['invoice_id'],
                    'cryptonator_payment_amount' => $_REQUEST['checkout_amount'],
                    'cryptonator_payment_type' => $_REQUEST['checkout_currency'],
                );

                if (fn_check_payment_script('cryptonator.php', $order_id)) {
                    fn_finish_payment($order_id, $pp_response);
                    $code = 200;
                }
            }
        } else {
        	exit;
        }
      
        
        header("Content-Type: text/xml; charset=utf-8");

        fn_ms_cryptonator_log_write("Response: ".$code, 'cryptonator_payment_callback.log');
        header("HTTP/1.0 ".$code,true,$code);
        http_response_code($code);

        exit;
    }

} else {

    $orderNumber = $order_info['order_id'] . '_' . substr(md5($order_info['order_id'] . TIME), 0, 3);
    $currency = mb_strtolower($processor_data['processor_params']['currency']);
    if($currency == 'rub') $currency = 'rur';

    $post_data = [
        'merchant_id' => $processor_data['processor_params']['merchant_id'],
        'order_id' => $order_id,
        'item_name' => 'Заказ №'.$order_id,
        'invoice_amount' => fn_format_price_by_currency($order_info['total'], CART_PRIMARY_CURRENCY, $processor_data['processor_params']['currency']),
        'invoice_currency' => $currency, 
        'language' => 'ru',
        //'checkout_currency' => !empty($payment_info['cryptonator_payment_type']) ? mb_strtolower($payment_info['cryptonator_payment_type']) : '',
        'success_url' => fn_url("payment_notification.ok?payment=cryptonator&ordernumber=$order_id", AREA, 'https'),
        'failed_url' => fn_url("payment_notification.error?payment=cryptonator&ordernumber=$order_id", AREA, 'https'),
    ];

    $cryptonator = new MerchantAPI( $processor_data['processor_params']['merchant_id'], $processor_data['processor_params']['secret'] );

    $post_data['secret_hash'] = $cryptonator->generateHash($post_data);
    $post_address = 'https://api.cryptonator.com/api/merchant/v1/startpayment';

    if (!empty($processor_data['processor_params']['logging']) && $processor_data['processor_params']['logging'] == 'Y') {
        fn_ms_cryptonator_log_write($post_data, 'cryptonator_post_data.log');
    }

    fn_create_payment_form($post_address, $post_data, 'Cryptonator', false, 'get');
}

exit;

<?php
/***************************************************************************
* @developer Kaminsky Edward, MakeShop.pro
* @module ms_cryptonator
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'details') {

    $order_info = fn_get_order_info($_REQUEST['order_id']);

    if (!empty($_REQUEST['payment_id'])) {
        $payment_info = fn_get_payment_method_data($_REQUEST['payment_id']);
        Tygh::$app['view']->assign('payment_info', $payment_info);
    }

}

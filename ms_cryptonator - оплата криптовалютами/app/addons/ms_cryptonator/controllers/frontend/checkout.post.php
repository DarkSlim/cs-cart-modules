<?php
/***************************************************************************
* @developer Kaminsky Edward, MakeShop.pro
* @module ms_cryptonator
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

$cart = $_SESSION['cart'];

if ($mode == 'checkout') {
    $phone = '';
    if (!empty($cart['user_data']['phone'])) {
        $phone = $cart['user_data']['phone'];

    } elseif (!empty($cart['user_data']['b_phone'])) {
        $phone = $cart['user_data']['b_phone'];

    } elseif (!empty($cart['user_data']['s_phone'])) {
        $phone = $cart['user_data']['s_phone'];
    }

    $payment_id = (!empty($cart['payment_method_data']['payment_id'])) ? $cart['payment_method_data']['payment_id'] : 0;
    $processor_script = db_get_field("SELECT processor_script FROM ?:payments INNER JOIN ?:payment_processors USING (processor_id) WHERE payment_id = ?i", $payment_id);
}

<?php
/***************************************************************************
* @developer Kaminsky Edward, MakeShop.pro
* @module ms_cryptonator
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

use Tygh\Registry;
use Tygh\Http;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'details') {
    $order_info = Tygh::$app['view']->getTemplateVars('order_info');

    if ($order_info && !empty($order_info['payment_method']['processor_id'])) {
        $processor_id = $order_info['payment_method']['processor_id'];
        $processor_script = db_get_field("SELECT processor_script FROM ?:payment_processors WHERE processor_id = ?i", $processor_id);

        Tygh::$app['view']->assign('processor_script', $processor_script);
    }

}

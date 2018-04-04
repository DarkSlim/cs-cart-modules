<?php
/***************************************************************************
* @developer Kaminsky Edward, MakeShop.pro
* @module ms_cryptonator
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

fn_trusted_vars("processor_params", "payment_data");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if ($mode == 'update') {
        $payment_id = fn_attach_image_pairs('path_stamp', 'stamp', $_REQUEST['payment_id'], DESCR_SL);
    }

    return array(CONTROLLER_STATUS_OK, "payments.manage");
}

if ($mode == 'update' || $mode == 'manage') {

    $processors = Tygh::$app['view']->getTemplateVars('payment_processors');

    if (!empty($processors)) {
        $cryptonator = array();
        foreach (fn_get_schema('ms_cryptonator', 'processors') as $processor) {
            $cryptonator[$processor['processor']] = $processor;
        }

        foreach ($processors as &$processor) {
            if (!empty($cryptonator[$processor['processor']])) {
                $processor['crypto'] = 'Y';
                $processor['type'] = 'C';

                if (isset($cryptonator[$processor['processor']]['position'])) {
                    $processor['position'] = 'a_' . $cryptonator[$processor['processor']]['position'];
                }
            }
        }
        $processors = fn_sort_array_by_key($processors, 'position');
        
        Tygh::$app['view']->assign('payment_processors', $processors);
    }
} elseif ($mode == 'processor') {

    $payment_image = array();

    if (!empty($_REQUEST['payment_id'])) {
        $processor_script = db_get_field("SELECT processor_script FROM ?:payments INNER JOIN ?:payment_processors USING (processor_id) WHERE payment_id = ?i", $_REQUEST['payment_id']);
        if ($processor_script == 'account.php') {
            $payment_image = $_REQUEST;
            $payment_image['path_stamp'] = fn_get_image_pairs($_REQUEST['payment_id'], 'stamp', 'M', true, true, DESCR_SL);

            Tygh::$app['view']->assign('payment_image', $payment_image);
        }
    }

    if (!empty($_REQUEST['processor_id'])) {
        $processor_script = db_get_field("SELECT processor_script FROM ?:payment_processors WHERE processor_id = ?i", $_REQUEST['processor_id']);
    }

    if (!empty($processor_script) && ($processor_script == 'account.php')) {
        $profile_fields = fn_get_profile_fields('ALL', array(), CART_LANGUAGE);
        Tygh::$app['view']->assign('profile_fields', $profile_fields);
        Tygh::$app['view']->assign('account_fields', fn_get_schema('rus_payments', 'account_fields'));
    }

}


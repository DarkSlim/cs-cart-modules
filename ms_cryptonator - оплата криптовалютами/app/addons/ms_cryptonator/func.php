<?php
/***************************************************************************
* @developer Kaminsky Edward, MakeShop.pro
* @module ms_cryptonator
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

use Tygh\Http;
use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }


function fn_ms_cryptonator_install()
{
    $payments = fn_get_schema('ms_cryptonator', 'processors', 'php', true);

    if (!empty($payments)) {
        foreach ($payments as $payment) {

            $processor_id = db_get_field("SELECT processor_id FROM ?:payment_processors WHERE admin_template = ?s", $payment['admin_template']);

            if (empty($processor_id)) {
                db_query('INSERT INTO ?:payment_processors ?e', $payment);
            } else {
                db_query("UPDATE ?:payment_processors SET ?u WHERE processor_id = ?i", $payment, $processor_id);
            }
        }
    }

    $statuses = fn_get_schema('ms_cryptonator', 'statuses', 'php', true);

    if (!empty($statuses)) {
        foreach ($statuses as $status_name => $status_data) {
            $status = fn_update_status('', $status_data, $status_data['type']);
            fn_set_storage_data($status_name, $status);
        }
    }
}

function fn_ms_cryptonator_normalize_phone($phone)
{
    $phone_normalize = '';

    if (!empty($phone)) {
        if (strpos('+', $phone) === false && $phone[0] == '8') {
            $phone[0] = '7';
        }

        $phone_normalize = str_replace(array(' ', '(', ')', '-'), '', $phone);
    }

    return $phone_normalize;
}

function fn_ms_cryptonator_uninstall()
{
    $payments = fn_get_schema('ms_cryptonator', 'processors');
    fn_ms_cryptonator_disable_payments($payments, true);

    foreach ($payments as $payment) {
        db_query("DELETE FROM ?:payment_processors WHERE admin_template = ?s", $payment['admin_template']);
    }

    $statuses = fn_get_schema('ms_cryptonator', 'statuses', 'php', true);
    if (!empty($statuses)) {
        foreach ($statuses as $status_name => $status_data) {
            fn_delete_status(fn_get_storage_data($status_name), 'O');
        }
    }
}

function fn_ms_cryptonator_disable_payments($payments, $drop_processor_id = false)
{
    $fields = '';
    if ($drop_processor_id) {
        $fields = 'processor_id = 0,';
    }

    foreach ($payments as $payment) {
        $processor_id = db_get_field("SELECT processor_id FROM ?:payment_processors WHERE admin_template = ?s", $payment['admin_template']);

        if (!empty($processor_id)) {
            db_query("UPDATE ?:payments SET $fields status = 'D' WHERE processor_id = ?i", $processor_id);
        }
    }
}

function fn_ms_cryptonator_log_write($data, $file)
{
    $path = fn_get_files_dir_path();
    fn_mkdir($path);
    $file = fopen($path . $file, 'a');

    if (!empty($file)) {
        fputs($file, 'TIME: ' . date('Y-m-d H:i:s', time()) . "\n");
        fputs($file, fn_array2code_string($data) . "\n\n");
        fclose($file);
    }
}
<?php


// при создании заказов, добавляем значение roistat из куков
function fn_ms_roistat_create_order(&$order) {

    if ($_REQUEST['dispatch'] == "checkout.place_order") {         
        if (!empty($_COOKIE['roistat_visit'])) {

            $order['ms_roistat'] = $_COOKIE['roistat_visit'];
        }
    }
}
// добавляем новое поле roistat
function fn_ms_roistat_pre_get_orders($params, &$fields) {

    if ($_REQUEST['dispatch'] == "exim_1c") {

        $fields = array (
            "distinct ?:orders.order_id",
            "?:orders.issuer_id",
            "?:orders.user_id",
            "?:orders.is_parent_order",
            "?:orders.parent_order_id",
            "?:orders.company_id",
            "?:orders.company",
            "?:orders.timestamp",
            "?:orders.firstname",
            "?:orders.lastname",
            "?:orders.email",
            "?:orders.company",
            "?:orders.phone",
            "?:orders.status",
            "?:orders.total",
            "?:orders.ms_roistat",        
            "invoice_docs.doc_id as invoice_id",
            "memo_docs.doc_id as credit_memo_id",
            "CONCAT(issuers.firstname, ' ', issuers.lastname) as issuer_name"
        );    
    }
}

// добавляем поле roistat в xml для моего_склада
function fn_ms_roistat_rus_exim_1c_order_data($order_data, &$order_xml) {

    
    if (empty($order_data['ms_roistat'])) {

        unset($order_data['ms_roistat']);
    } else {

        // из-за оссобеностей обработки xml Моим Складом, нужно обернуть поле на английском
        $order_xml['ЗначенияРеквизитов']['ЗначениеРеквизита']['Наименование'] = "roistat";
        $order_xml['ЗначенияРеквизитов']['ЗначениеРеквизита']['Значение'] = $order_data['ms_roistat'];
        
    }

}

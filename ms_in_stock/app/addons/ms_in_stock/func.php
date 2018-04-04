<?php
/***************************************************************************
* @copyright Kaminsky Edward, http://makeshop.pro
* @module ms_in_stock
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

function fn_ms_in_stock_get_order_items_info_post(&$order)
{
    
    $order_id = $order['order_id'];

    foreach ($order['products'] as $product) {
        $product_id = $product['product_id'];
        $qtt_my = db_get_field(' SELECT ?:products.amount from cscart_products
                            where ?:products.product_id in (?a)', $product_id);
        $order['products'][$product['item_id']]['qtt_my'] = $qtt_my;
    }
}

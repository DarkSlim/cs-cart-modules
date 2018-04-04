<?php

if (!defined('BOOTSTRAP')) { die('Access denied'); }

fn_register_hooks (
    'create_order',
    'pre_get_orders',
    'rus_exim_1c_order_data'
);

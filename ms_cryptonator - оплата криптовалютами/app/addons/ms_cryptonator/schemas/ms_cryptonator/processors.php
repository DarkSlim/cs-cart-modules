<?php
/***************************************************************************
* @developer Kaminsky Edward, MakeShop.pro
* @module ms_cryptonator
* @version 1.0.0
* @license GNU GPL 3
****************************************************************************/

$schema = array(
    'cryptonator' => array(
        'processor' => 'Cryptonator',
        'processor_script' => 'cryptonator.php',
        'processor_template' => 'addons/ms_cryptonator/views/orders/components/payments/cryptonator.tpl',
        'admin_template' => 'cryptonator.tpl',
        'callback' => 'Y',
        'type' => 'P',
        'position' => 10,
        'addon' => 'ms_cryptonator',
    ),
);

return $schema;

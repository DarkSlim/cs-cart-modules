<?php
/***************************************************************************
* @copyright Kaminsky Edward, MakeShop.pro
* @module ms_beaty_options
* @version 2.10.1
* @license GNU GPL 3
****************************************************************************/

use Tygh\Registry;
use Tygh\Settings;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'list_colors') {

	$variant_name = Registry::get('addons.ms_beaty_options.input_color');

	$search = fn_settings_variants_addons_ms_beaty_options_get_list_colors($variant_name);

}

if ($mode == 'set_awesome_code_color') {

	fn_ms_beaty_options_make_awesome();

	return array(CONTROLLER_STATUS_OK, 'ms_beaty_options.list_colors');
}


if ($mode == 'update_color') {

	if ($_REQUEST['colors_data']) {

		$colors_data = $_REQUEST['colors_data'];		
	//	fn_print_die($colors_data);
		fn_settings_variants_addons_ms_beaty_options_update_color($colors_data);

	}
	
	return array(CONTROLLER_STATUS_OK, 'ms_beaty_options.list_colors');
}
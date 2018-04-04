<?php
use Tygh\Registry;
// пост-контроллер для вытягивания из бд id визита roistat
if ($mode = 'details') {
	//определяем id заказа
	$order_id = isset($_REQUEST['order_id']) ? (int) $_REQUEST['order_id'] : null;
	// достаем из бд значение roistat id из столбца ms_roistat
	$ms_r_user_id_list = db_get_row("SELECT ms_roistat FROM ?:orders WHERE order_id = ?i", $order_id);
	// добавляем в smarty содержимое переменной ms_r_user_id
	foreach ($ms_r_user_id_list as $ms_r_user_id) {
	Registry::get('view')->assign('ms_r_user_id', $ms_r_user_id);
	}
}

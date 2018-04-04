<?php
use Tygh\Registry;
use Tygh\__;

if (!defined('BOOTSTRAP')) { die('Access denied'); }


if ($mode == 'list') {
	
	$_GET['page'] = empty($_GET['page']) ? 1 : (int) $_GET['page'];
	
	$count = (int) Registry::get('addons.ms_yandex_opinions.count');
	if($count > 30) $count = 30;
	elseif($count < 1) $count = 1;
	
	
	$params = array_filter(
		array(
			'how'			=> Registry::get('addons.ms_yandex_opinions.how'),
			'max_comments' 	=> Registry::get('addons.ms_yandex_opinions.max_comments'),
			'sort'			=> Registry::get('addons.ms_yandex_opinions.sort'),
		),
		create_function('$v', 'return isset($v) && $v !== "";')
	);
	
	
	$data = fn_ms_yandex_opinions_get_shop_opinions(
		$count,
		str_replace('filter_', '', Registry::get('addons.ms_yandex_opinions.grade')),
		$params['how'],
		$params['max_comments'],
		$params['sort'],
		$_GET['page']
	);
	
	if (empty($data)) {
		return array(CONTROLLER_STATUS_NO_PAGE);
	}
	
	
	
	$offset = ($_GET['page'] - 1) * $count;
	if($offset >= $data['total']){
		return array(CONTROLLER_STATUS_REDIRECT, fn_query_remove(Registry::get('config.current_url'), 'page'));
	}
	
	
	//fn_generate_pagination();
	
	Tygh::$app['view']->assign('search', array(
		'total_items'		=> $data['total'],
		'items_per_page'	=> $count,
		'page'				=> $_GET['page'],
	));
	Tygh::$app['view']->assign('data', $data);
	Tygh::$app['view']->assign('title', __('ms_yandex_opinions_list_title'));
	
}

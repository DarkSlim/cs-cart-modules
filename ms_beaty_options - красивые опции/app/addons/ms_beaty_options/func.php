<?php
/***************************************************************************
* @copyright Kaminsky Edward, MakeShop.pro
* @module ms_beaty_options
* @version 2.10.1
* @license GNU GPL 3
****************************************************************************/

use Tygh\Registry;

function fn_ms_beaty_options_set_default_colors()
{

	$variant_name = Registry::get('addons.ms_beaty_options.input_color');	

	$list_colors = fn_settings_variants_addons_ms_beaty_options_get_list_colors($variant_name);

	$update = fn_settings_variants_addons_ms_beaty_options_update_color($list_colors);	

	return true;
}

function fn_settings_variants_addons_ms_beaty_options_get_list_colors($variant_name)
{	
	$row_list = db_get_array('

		SELECT DISTINCT variant_name 
		FROM ?:product_option_variants_descriptions 
		WHERE variant_id in (

		SELECT variant_id 
		FROM ?:product_option_variants 
		WHERE option_id in (

		SELECT DISTINCT option_id 
		FROM ?:product_option_variants 
		WHERE option_id in (

		SELECT option_id 
		FROM ?:product_options_descriptions 
		WHERE option_name like ?l )))', $variant_name);

	//убираем лишнее
	foreach ($row_list as $key => $variant) {

		$name = $variant['variant_name'];
		$list_colors[$name]['color_name'] = $variant['variant_name'];
		
		if (strpos($name, '/') !== false) {
					
			$result = explode("/", $name);
			
			foreach ($result as $v => $r) {
			
				$list_colors[$name][$v]['color_name'] = $r;
				
				//fn_print_r($list_colors[$name]['color_name']);
				
				$color_hex = fn_settings_variants_addons_ms_beaty_options_search_hex_code($r);
					
				$list_colors[$name][$v]['color_hex'] = $color_hex;
			
			}
		
		} else {
		
			/* ищем hex код из бд */			
			$color_hex = fn_settings_variants_addons_ms_beaty_options_search_hex_code($variant['variant_name']);		
	
			$list_colors[$name]['color_hex'] = $color_hex;
			
		}

	}
	
 //fn_print_die($list_colors);

	/* чтобы передать значения в smarty */
	$view = Registry::get('view');
	$view->assign('list_colors', $list_colors);

	return $list_colors;
}

//ищем код цвета для переданного имени цвета
function fn_settings_variants_addons_ms_beaty_options_search_hex_code($color)
{
	$color_hex = db_get_field('SELECT color_hex FROM ?:ms_beaty_options_colors WHERE color_name like ?l', $color);	

	//если код цвета не передали, устанавливаем по умолчанию
	$default_color = "#bdbdbd";
	if (empty($color_hex)) { 
		$color_hex = $default_color;
	}

	/* чтобы передать значения в smarty */
	$view = Registry::get('view');
	$view->assign('color_hex', $color_hex);	

	return $color_hex;
}

function fn_settings_variants_addons_ms_beaty_options_update_color($colors_data)
{
	{	
		
		foreach ($colors_data as $key => $color_data) {
			
			/* есть ли в бд этот цвет */
			$res = db_get_field('SELECT COUNT(*) FROM ?:ms_beaty_options_colors  WHERE color_name like ?l', $color_data['color_name']);
			
			/* если есть, обновляем */
			if ($res == 1) {
				$update = db_query('UPDATE ?:ms_beaty_options_colors SET ?u WHERE color_name like ?l', $color_data, $color_data['color_name']);					
			}

			/* если нет, добавляем */
			else {
				$insert = db_query('INSERT INTO ?:ms_beaty_options_colors ?e', $color_data);		
			}				
			
		}/* end foreach */		

	}
	
	return true;
}

function fn_ms_beaty_options_make_awesome()
{

	//цвета по которым будем искать
	$colors_from_yandex_market = array(
		array('color_name' => 'бежевый','color_hex' => '#FFEEDD'),
		array('color_name' => 'beige','color_hex' => '#FFEEDD'),
		array('color_name' => 'белый','color_hex' => '#FFFFFF'),
		array('color_name' => 'white','color_hex' => '#FFFFFF'),
		array('color_name' => 'бирюзовый','color_hex' => '#30D5C8'),
		array('color_name' => 'turquoise','color_hex' => '#30D5C8'),
		array('color_name' => 'бордовый','color_hex' => '#990033'),
		array('color_name' => 'burgundy','color_hex' => '#990033'),
		array('color_name' => 'голубой','color_hex' => '#85D6FF'),
		array('color_name' => 'blue','color_hex' => '#85D6FF'),
		array('color_name' => 'желтый','color_hex' => '#FFFF00'),
		array('color_name' => 'yellow','color_hex' => '#FFFF00'),
		array('color_name' => 'зеленый','color_hex' => '#009900'),
		array('color_name' => 'green','color_hex' => '#009900'),
		array('color_name' => 'золотистый','color_hex' => '#FFD700'),
		array('color_name' => 'golden','color_hex' => '#FFD700'),
		array('color_name' => 'коричневый','color_hex' => '#964b00'),
		array('color_name' => 'brown','color_hex' => '#964b00'),
		array('color_name' => 'красный','color_hex' => '#FF0000'),
		array('color_name' => 'red','color_hex' => '#FF0000'),
		array('color_name' => 'оливковый','color_hex' => '#808000'),
		array('color_name' => 'olive','color_hex' => '#808000'),
		array('color_name' => 'оранжевый','color_hex' => '#FF6600'),
		array('color_name' => 'Orange','color_hex' => '#FF6600'),
		array('color_name' => 'разноцветный','color_hex' => 'mixed'),
		array('color_name' => 'Colorful','color_hex' => 'mixed'),
		array('color_name' => 'розовый','color_hex' => '#ffc0cb'),
		array('color_name' => 'pink','color_hex' => '#ffc0cb'),
		array('color_name' => 'рыжий','color_hex' => '#D14719'),
		array('color_name' => 'ginger','color_hex' => '#D14719'),
		array('color_name' => 'салатовый','color_hex' => '#99FF99'),
		array('color_name' => 'lime green','color_hex' => '#99FF99'),
		array('color_name' => 'светло-розовый','color_hex' => '#FFE1EE'),
		array('color_name' => 'light pink','color_hex' => '#FFE1EE'),
		array('color_name' => 'серебристый','color_hex' => '#F1F1F1'),
		array('color_name' => 'silver','color_hex' => '#F1F1F1'),
		array('color_name' => 'серый','color_hex' => '#808080'),
		array('color_name' => 'gray','color_hex' => '#808080'),
		array('color_name' => 'синий','color_hex' => '#3333FF'),
		array('color_name' => 'blue','color_hex' => '#3333FF'),
		array('color_name' => 'сиреневый','color_hex' => '#C8A2C8'),
		array('color_name' => 'lilac','color_hex' => '#C8A2C8'),
		array('color_name' => 'темно-зеленый','color_hex' => '#005000'),
		array('color_name' => 'dark green','color_hex' => '#005000'),
		array('color_name' => 'темно-коричневый','color_hex' => '#654321'),
		array('color_name' => 'dark brown','color_hex' => '#654321'),
		array('color_name' => 'темно-серый','color_hex' => '#49423d'),
		array('color_name' => 'dark grey','color_hex' => '#49423d'),
		array('color_name' => 'темно-синий','color_hex' => '#103090'),
		array('color_name' => 'dark blue','color_hex' => '#103090'),
		array('color_name' => 'фиолетовый','color_hex' => '#9900CC'),
		array('color_name' => 'purple','color_hex' => '#9900CC'),
		array('color_name' => 'хаки','color_hex' => '#BDB76B'),
		array('color_name' => 'khaki','color_hex' => '#BDB76B'),
		array('color_name' => 'черный','color_hex' => '#000000'),
		array('color_name' => 'black','color_hex' => '#000000'),
		array('color_name' => 'ярко-розовый','color_hex' => '#fc0fc0'),
		array('color_name' => 'bright pink','color_hex' => '#fc0fc0')
		);

	foreach ($colors_from_yandex_market as $key => $color_data) {

		$color_name = $color_data['color_name'];
		$color_hex = $color_data['color_hex'];

		//ищем совпадения названия цветов по нечувствительному регистру
		$res = db_get_field('SELECT count(*) FROM ?:ms_beaty_options_colors WHERE LOWER(color_name) LIKE LOWER (?l)', $color_name);		

		//если находимо строчку, где есть этот цвет, копируем код цвета
		if ($res == 1) {
			$update = db_query('UPDATE ?:ms_beaty_options_colors SET color_hex = ?s WHERE LOWER(color_name) LIKE LOWER (?l)', $color_hex, $color_name);			
		}//end if
	}//end foreach
		
}

// сохраняем название выбранных фильтров, чтобы потом искать по ним
function fn_ms_beaty_options_get_filters_products_count_post($params, $lang_code, &$filters) 
{
		$variant_name = Registry::get('addons.ms_beaty_options.input_color');

		// ищем фильтр с названием Цвет
        foreach ($filters as $key => $feature) {
        
            if ($feature['filter'] == $variant_name)  {                

                foreach ($feature['selected_variants'] as $key2 => $variant) {
                   
                   $filters[$key]['selected_variants'][$key2]['name_feature'] = $variant_name;
                }             
               
            }
        }

        return true;

}
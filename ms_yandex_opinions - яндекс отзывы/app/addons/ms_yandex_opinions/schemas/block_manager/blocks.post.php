<?php 

$schema['ms_yandex_opinions'] = array(
	
	/*'content' => array(
		'phone_number' => array(
			'type' => 'function',
			'function' => array('fn_call_requests_get_splited_phone'),
		),
	),*/
	
	'templates' => array(

		'addons/ms_yandex_opinions/blocks/opinions_native.tpl' => array(
			
			'settings' => array (
				'max_comments' => array (
					'type' => 'input',
					'default_value' => 1,
				),
			),
			
		),
		'addons/ms_yandex_opinions/blocks/opinions_discussion.tpl' => array(),
		
	),
		

	'settings' => array (
		'count' => array (
			'type' => 'input',
			'default_value' => 3, // up to 30
		),
		'grade' => array (
			'type' => 'selectbox',
			'values' => array (
				'filter_' => 'msyo_block_no_grade',
				'filter_-2' => 'msyo_block_grade_-2',
				'filter_-1' => 'msyo_block_grade_-1',
				'filter_0' => 'msyo_block_grade_0',
				'filter_1' => 'msyo_block_grade_1',
				'filter_2' => 'msyo_block_grade_2',
			),
			'default_value' => '',
		),
		'how' => array (
			'type' => 'selectbox',
			'values' => array (
				'asc' => 'msyo_block_how_asc',
				'desc' => 'msyo_block_how_desc',
			),
			'default_value' => 'desc',
		),
		'sort' => array (
			'type' => 'selectbox',
			'values' => array (
				'grade' => 'msyo_block_sort_grade',
				'date' => 'msyo_block_sort_date',
				'rank' => 'msyo_block_sort_rank',
			),
			'default_value' => 'date',
		),
	),
	
	'wrappers' => 'blocks/wrappers',
	
	'cache' => array (
		'update_handlers' => array ('ms_yandex_opinions'),
	),
	
	
);

return $schema;
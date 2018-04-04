<?php 

use Tygh\Registry;

/**
 * 
 * @param string $uri
 * @param string $key
 * @param array $params
 * @throws Exception
 * @return boolean|mixed
 */
function fn_ms_yandex_opinions_api_get($uri, array $params = array()){
	static $key = null;
	
	if(!isset($key)){
		$key = Registry::get('addons.ms_yandex_opinions.key');
	}
	
	
	$url = "https://api.content.market.yandex.ru/v1/{$uri}.json?".http_build_query($params);
	
	$headers = array(
		"Authorization: $key"
	);
	
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_HEADER, false);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_TIMEOUT, 2);
	$data = curl_exec($ch);
	curl_close($ch);
	
	if($data === false){
		return false;
	}
	
	$data = json_decode($data, true);
	
	if(is_array($data)){
		
		if(isset($data['errors'])){
			foreach($data['errors'] as $error){
				throw new Exception($error);
			}
		}
		
		return $data;
	}

	return false;
}


function fn_ms_yandex_opinions_api_get_cache($uri, array $params = array(), $ttl = 86400){
	static $cache_misc_dir = null;
	if(is_null($cache_misc_dir)){
		$cache_misc_dir = Registry::get('config.dir.cache_misc');
	}
	$cache_file = $cache_misc_dir.__FUNCTION__.'-'.md5(serialize(compact('uri', 'params')));
	if( file_exists($cache_file)
	&& filemtime($cache_file) > (time()-$ttl) ){
		return unserialize(file_get_contents($cache_file));
	}
	try{
		$data = fn_ms_yandex_opinions_api_get($uri, $params);
	}catch(Exception $e){
		fn_set_notification('E', fn_get_lang_var('error'), $e->getMessage(), 'S');
	}
	if($data !== false){
		file_put_contents($cache_file, serialize($data));
	}
	return $data;
}


/**
 * 
 * @param integer $id
 * @return boolean|array
 */
function fn_ms_yandex_opinions_api_get_region($id){
	$data = fn_ms_yandex_opinions_api_get_cache("georegion/{$id}", array(), 7*24*3600);
	return isset($data['georegion']) ? $data['georegion'] : false;
}

/**
 * 
 * @param integer $id
 * @return boolean|array
 */
function fn_ms_yandex_opinions_get_region($id){
	static $memory_cache = array();
	
	if(isset($memory_cache[$id])){
		$data = $memory_cache[$id];
	}else{
		$data = fn_ms_yandex_opinions_api_get_region($id);
		if($data) $memory_cache[$id] = $data;
	}
	
	return $data;
}


/**
 *
 * @param integer $id
 * @return boolean|string
 */
function fn_ms_yandex_opinions_get_region_name($id){
	$data = fn_ms_yandex_opinions_get_region($id);
	if($data){
		return $data['name'];
	}
	return false;
}

/**
 *
 * заказ номер opinion.shopOrderId
 * оценка opinion.grade
 * дата opinion.date
 *
 * opinion.anonymous true аноним
 * (opinion.visibility NAME) имя оценщика opinion.author
 * (opinion.visibility NAME) аватар адрес opinion.authorInfo.avatarUrl
 *
 * opinion.delivery DELIVERY доствка
 * opinion.delivery PICKUP самовывоз
 *
 * достоинства opinion.pro
 * комментарий opinion.text
 * недостатки opinion.contra
 *
 * первый коммент текст opinion.comments[0].body
 * первый коммент дата opinion.comments[0].updateTimestamp
 *
 * @param int $shop_id
 * @param array $params
 * @throws Exception
 * @return boolean|array
 */
function fn_ms_yandex_opinions_api_get_shop_opinions($shop_id, array $params = array()){

	$data = fn_ms_yandex_opinions_api_get_cache("shop/{$shop_id}/opinion", $params, 24*3600);

	if(is_array($data) && isset($data['shopOpinions'])){
		return $data['shopOpinions'];
	}

	return false;
}

/**
 * 
 * @param number $count
 * @param string $grade
 * @param string $how
 * @param string $max_comments
 * @param string $sort
 * @param number $page
 * @return boolean|array
 */
function fn_ms_yandex_opinions_get_shop_opinions($count = 10, $grade = null, $how = 'desc', $max_comments = '0', $sort = 'date', $page = 1){
	
	static $params_filter_callback = null;
	
	if(!is_callable($params_filter_callback)){
		$params_filter_callback = create_function('$v', 'return isset($v) && $v !== "";');
	}
	
	//var_dump(Registry::get('addons.ms_yandex_opinions')); // .ms_yandex_opinions.main
	
	if(Registry::get('addons.ms_yandex_opinions.sample_data') == 'Y'){
		$data = include __DIR__.'/sample_data.php';
		if($count){
			$data['opinion'] = array_slice($data['opinion'], (($page?$page:1)-1)*$count, $count);
			$data['page'] = $page;
		}
		return $data;
	}
	
	$params = array_filter(
		compact('count', 'grade', 'how', 'max_comments', 'sort', 'page'),
		$params_filter_callback
	);
	
	return fn_ms_yandex_opinions_api_get_shop_opinions(
		Registry::get('addons.ms_yandex_opinions.shop_id'),
		$params
	);
}



/*
function fn_ymapi_get_shop_opinions_cache($shop_id, $key, array $params = array()){
	$cache_key = __FUNCTION__.'.'.md5(serialize(compact('shop_id', 'params')));
	Registry::cacheInit();
	Registry::get($k)($cache_key, $v);
}

var_export($expression)



var_export(
	fn_ymapi_get_shop_opinions(320642, "Enter API 00000000000000000000", array(
		'count' => '10',
		'grade' => '2',
		'how' => 'desc',
		'max_comments' => '1',
		//'page' => '0',
		//'sort' => 'grade',
		//'' => '',
	))
);
*/




/**
 * 
 * @param float $rating_value
 * @return array
 */
function fn_get_ms_yandex_opinions_rating($rating_value){
    static $cache = array();

    if (!isset($cache[$rating_value])) {
        $cache[$rating_value] = array();
        $cache[$rating_value]['full'] = floor($rating_value);
        $cache[$rating_value]['part'] = $rating_value - $cache[$rating_value]['full'];
        $cache[$rating_value]['empty'] = 5 - $cache[$rating_value]['full'] - (($cache[$rating_value]['part'] == 0) ? 0 : 1);

        if (!empty($cache[$rating_value]['part'])) {
            if ($cache[$rating_value]['part'] <= 0.25) {
                $cache[$rating_value]['part'] = 1;
            } elseif ($cache[$rating_value]['part'] <= 0.5) {
                $cache[$rating_value]['part'] = 2;
            } elseif ($cache[$rating_value]['part'] <= 0.75) {
                $cache[$rating_value]['part'] = 3;
            } elseif ($cache[$rating_value]['part'] <= 0.99) {
                $cache[$rating_value]['part'] = 4;
            }
        }
    }

    return $cache[$rating_value];
}

?>
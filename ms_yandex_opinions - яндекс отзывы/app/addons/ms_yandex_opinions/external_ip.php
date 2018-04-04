<?php

if(empty($_GET['self'])){
	echo file_get_contents(
		(empty($_SERVER['HTTPS'])||$_SERVER['HTTPS']=='off' ? 'http' : 'https')
		.'://'.$_SERVER['HTTP_HOST']
		.(isset($_SERVER['SERVER_PORT']) ? ':'.$_SERVER['SERVER_PORT'] : '')
		.$_SERVER['PHP_SELF'].'?self=1'
	);
}else{
	echo $_SERVER['REMOTE_ADDR'];
}
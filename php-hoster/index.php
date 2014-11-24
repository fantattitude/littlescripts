<?php

function to10($num, $b=62)
{
	$base='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$limit = strlen($num);
	$res=strpos($base,$num[0]);
	for($i=1;$i<$limit;$i++)
	{
		$res = $b * $res + strpos($base,$num[$i]);
	}
	return $res;
}

//parse_str(implode('&', array_slice($argv, 1)), $_GET);

$query = str_replace('/', '', $_GET['q']);
$filename = 'Screen ' . to10($query) . '.png';

if (file_exists($filename))
{
	header('Content-type: image/png');
	readfile($filename);
}

?>

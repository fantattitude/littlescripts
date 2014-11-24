<?php

$url = 'http://domain.com/';
	
function toBase($num, $b=62)
{
	$base='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$r = $num  % $b ;
	$res = $base[$r];
	$q = floor($num/$b);
	while ($q)
	{
		$r = $q % $b;
		$q =floor($q/$b);
		$res = $base[$r].$res;
	}
	return $res;
}

parse_str(implode('&', array_slice($argv, 1)), $_GET);

$filename = $_GET['q'];
preg_match('!\d+!', $filename, $matches);

echo($url . toBase($matches[0]));

?>

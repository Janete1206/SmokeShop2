<?php
include_once ("cosas/headers.php");
$fp = fopen("data.json","r");
$json="";
while (!feof($fp)){
    $linea = fgets($fp);
    $json.=$linea;
}
print $json;
fclose($fp);
?>

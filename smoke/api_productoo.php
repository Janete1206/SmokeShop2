<?php
include_once ("cosas/headers.php");
use DBC\conexion as dbc;
require "vendor/autoload.php";
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);

@$id = $request->id;
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $query = " DELETE FROM producto where id = '".$id."'" ;
    $result = dbc::eliminar($query);
    $info['status'] = $result;
    echo json_encode($info);
}
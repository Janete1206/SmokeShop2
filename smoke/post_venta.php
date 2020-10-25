<?php
include_once ("cosas/headers.php");
use DBC\conexion as dbc;
require "vendor/autoload.php";
$postdata = file_get_contents("php://input");
if (isset($postdata)) {
    $request = json_decode($postdata);
    if (isset($request->tableRows)) {
        $data = $request->tableRows;
        $respuesta = dbc::registrotrans($data);
    }else{
        $respuesta = "NEL";
    }
    echo json_encode($respuesta);
}else{
    echo json_encode('fallo');
}


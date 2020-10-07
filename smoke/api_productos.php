<?php
include_once ("cosas/headers.php");
use DBC\conexion as dbc;
require "vendor/autoload.php";
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);

@$id = $request->id;
@$nombre = $request->nombre;
@$imagen = $request->imagen;
$ruta="http://localhost/smoke/imagenes/".$imagen;
@$descripcion = $request->descripcion;
@$precio = $request->precio;
@$stock = $request-> stock;
@$stock_minimo = $request -> stock_minimo;
@$codigo_barras = $request -> codigo_barras;

// insertar un producto
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $query = "CALL insert_products('" . $ruta . "' ,'" . $nombre . "' , '" . $descripcion . "',
    '" . $precio . "','" . $stock . "', '" . $stock_minimo . "', '" . $codigo_barras . "');";
    $respuesta = dbc::registro($query) ;
    $info['status'] = $respuesta;
    echo json_encode($info);
}

//traer todos los registros
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $query = "SELECT * FROM view_product";
    $rows = dbc::consultas($query);
    echo json_encode(['data'=> $rows]);
}

// eliminar un producto

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    $query = " DELETE FROM producto where id = '".$id."'" ;
    $result = dbc::eliminar($query);
    $info['status'] = $result;
    echo json_encode($info);
}

if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    $query = "UPDATE producto SET nombre = '" . $nombre . "',imagen = '" . $imagen . "', descripcion = '" . $descripcion . "' ,
     precio = '" . $precio . "', stock = '" . $stock . "', stock_minimo = '" . $stock_minimo . "', codigo_barras = '" . $codigo_barras . "' 
      Where id = '" . $id . "' ";
    if ($respuesta = dbc::registro($query)) {
        $dataProvaider = ['success' => 1];
        echo json_encode($dataProvaider);
    } else {
        echo json_encode(['success' => 0], JSON_UNESCAPED_UNICODE);
    }
}

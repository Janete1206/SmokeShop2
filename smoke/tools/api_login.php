<?php
include_once("cosas/headers.php");
use DBC\conexion as dbc;
use aut\authToken as Token;
require "vendor/autoload.php";


$postdata = file_get_contents("php://input");
$post = json_decode($postdata);

@$email = $post->email;
@$password = $post->password;
$query = "SELECT id, nombre, email, password, rol FROM usuarios WHERE email = '".$email."' ";
$row = dbc::consulta($query);
//$rol = $row->rol;

if(password_verify($password, $row->password)){
    $query = "SELECT * FROM usuarios WHERE id ='".$row->id."'";
    $rol = dbc::consultas($query);

    $token = Token::obtenerToken([
        'id' => $row->id,
        'name' => $row->email,
        'rol' => $rol
    ]);
    $rol = $row->rol;
    $nombre = $row ->nombre;
    $dataProvaider=['success'=>1,'token'=>$token, 'rol'=>$rol, 'nombre'=>$nombre];
    echo json_encode($dataProvaider, JSON_UNESCAPED_UNICODE);
}else{
    echo json_encode(['success'=>0],JSON_UNESCAPED_UNICODE);
}


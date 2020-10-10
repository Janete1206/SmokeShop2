<?php
include_once ("cosas/headers.php");
use DBC\conexion as dbc;
require "vendor/autoload.php";
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
@$pass = $request-> password;
@$email = $request-> email;
@$contra = password_hash($pass,PASSWORD_DEFAULT, ['cost'=> 10]);

if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    $query = "UPDATE usuarios SET password = '" . $contra . "' Where email = '" . $email . "' ";
    if ($respuesta = dbc::registro($query)) {
        $dataProvaider = ['success' => 1];
        echo json_encode($dataProvaider);
    } else {
        echo json_encode(['success' => 0], JSON_UNESCAPED_UNICODE);
    }
}
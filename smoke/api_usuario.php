<?php
include_once ("cosas/headers.php");
use DBC\conexion as dbc;
use aut\authToken as Token;
require "vendor/autoload.php";
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);
@$nombre = $request->nombre;
@$email = $request->email;
@$password = $request->password;
@$contra = password_hash($password,PASSWORD_DEFAULT, ['cost'=> 10]);
@$rol = $request -> rol;
@$status = $request -> status;
@$correo =  $request -> ref ;
$args = explode('/', rtrim($_SERVER['QUERY_STRING'], '/'));
$option = array_shift($args);

switch ($option) {
    //see profile
      case "getPerfil";
          if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $query = "SELECT * from usuarios where email = '".$correo."' ";
            $rows = dbc::consultas($query);
            echo json_encode($rows);
          }
        break;
      case "login";
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

          break;
      case "insertaUsuario";
          if ($_SERVER['REQUEST_METHOD'] == 'POST') {
              $query = "CALL insert_usuario('" . $nombre . "' , '" . $email . "', '" . $contra . "','" . $rol . "');";
              if ($respuesta = dbc::registro($query)) {
                  $dataProvaider = ['success' => 1];
                  echo json_encode($dataProvaider);
              } else {
                  echo json_encode(['success' => 0], JSON_UNESCAPED_UNICODE);
              }
          }
          break;
      case "actualizaContrasena";
          if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
              $query = "UPDATE usuarios SET password = '" . $contra . "' Where email = '" . $email . "' ";
              if ($respuesta = dbc::registro($query)) {
                  $dataProvaider = ['success' => 1];
                  echo json_encode($dataProvaider);
              } else {
                  echo json_encode(['success' => 0], JSON_UNESCAPED_UNICODE);
              }
          }
          break;
    default:
        echo "bad gateway";
}
/*
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $query = "SELECT * FROM vista_user";
    $row = dbc::consulta($query);
    echo json_encode($row);
}

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    $query = " DELETE FROM usuarios where nombre = '".$nombre."'" ;
    $row = dbc::consulta($query);
    echo json_encode($query);
}


if ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    $query = "UPDATE usuarios SET nombre = '" . $nombre . "', email = '" . $email . "' ,
     password = '" . $contra . "', rol = '" . $rol . "', status = '" . $status . "' ";
    if ($respuesta = dbc::registro($query)) {
        $dataProvaider = ['success' => 1];
        echo json_encode($dataProvaider);
    } else {
        echo json_encode(['success' => 0], JSON_UNESCAPED_UNICODE);
    }
}
*/
<?php
include_once ("cosas/headers.php");
require "vendor/autoload.php";
use aut\authToken as Token;

$postdata = file_get_contents("php://input");
$post = json_decode($postdata);

@$token = $post->token;
@$rol = $post->rol;

$revision = Token::validarRBCA($token);

foreach ($revision as $item){
    if($item->rol==$rol){
        $msj=['success'=>1];
    }else{
        $msj=['success'=>0];
    }
}
    echo json_encode($msj, JSON_UNESCAPED_UNICODE);
?>



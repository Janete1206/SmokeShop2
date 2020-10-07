<?php
namespace aut;
use \Firebase\JWT\JWT;

class authToken{

    private static $key = 'j8ZzQ#XMtu13';
    private static $encrypt = ['HS256'];
    private static $audit = null;

    public static function obtenerToken($data){
        $time = time();
        $token = [
            'exp' => $time + (60*60),
            'aud' => self::Aud(),
            'data' => $data
        ];

        return JWT::encode($token, self::$key);
    }

    public static function obtenerData($token){
        return JWT::decode($token, 'j8ZzQ#XMtu13', self::$encrypt)->data;
    }

    public static function validar($token){
        try{
            $auditoria = JWT::decode($token, 'j8ZzQ#XMtu13', self::$encrypt)->aud;
            if($auditoria === self::Aud()){
                #return "Token Valido (>*-*)>";
                return true;
            }else{
                #return "Token No Valido (>¬¬)>";
                return false;
            }
        }catch(Exception $e){
            #return "Token No Valido (>¬¬)> <(¬¬<)";
            return false;
        }

    }
    public static function validarRBCA($token){
        return JWT::decode($token, 'j8ZzQ#XMtu13', self::$encrypt)->data->rol;
    }

    private static function Aud(){
        $aud ='';
        if(!empty($_SERVER['HTTP_CLIENT_IP'])){
            $aud = $_SERVER['HTTP_CLIENT_IP'];
        }elseif(!empty($_SERVER['HTTP_X_FORWARDED_FOR'])){
            $aud = $_SERVER['HTTP_X_FORWARDED_FOR'];
        }else{
            $aud = $_SERVER['REMOTE_ADDR'];
        }
        $aud .= @$_SERVER['HTTP_USER_AGENT'];
        $aud .= gethostname();
        return sha1($aud);
    }



}

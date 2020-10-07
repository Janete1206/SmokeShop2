<?php
namespace DBC;
class conexion
{
    protected static function conn(){
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "smoke";
        return mysqli_connect($servername, $username, $password, $dbname);
    }
    public static function verificar(){
        if(self::conn()->connect_errno){
            print_r("Error de coenxión");
            return false;
        }else{
            return true;
        }
    }
    public static function consulta($query){
        $resultado = mysqli_query(self::conn(), $query);
        $pass = mysqli_fetch_object($resultado);
          return $pass;
    }
    public static function registro($query){
        $db = self::conn();
        $respuesta = $db->query($query);
        return $respuesta;
    }

    public static function registrotrans($data){
        $db = self::conn();
        $db->autocommit(false);
        $error = 0;
        try{
            $query = "INSERT INTO ventas(fecha_venta, usuarios_id) VALUES (NOW(),1);";
            if(!$db->query($query)){
                $error+=1;
            }
            $ID = $db->insert_id;

            foreach ($data as $i => $item) {
                $nombre = $item->nombre;
                $precio = $item->precio;
                $stock = $item->stock;
                $cantidad = $item->cantidad;
                $cod = $item->codigo;
                $query = "INSERT INTO producto_has_ventas(Producto_id, ventas_id, cantidad, importe) 
              VALUES (
                  $cod,
                  $ID,
                  $cantidad,
                  $precio
              );";
                if(!$db->query($query)){
                    $error+=1;
                }

            }
            if($error == 0){
                $db->commit();
                return 1;
            }else{
                return 0;
            }

        }catch ( \Exception $e){
            return  0;
        }
    }

    public static function registro2($query){
        $db = self::conn();
        $db->query($query);
        $respuesta = $db->insert_id;
        $db->close();
        return $respuesta;

    }
    public static function consultas($query){
        $resultado = mysqli_query(self::conn(), $query);
        while ($row = mysqli_fetch_object($resultado)){
            $pass[]=$row;
        }
        return $pass;
    }
    public static function grafica($query){
        $resultado = mysqli_query(self::conn(), $query);
        return $resultado;
    }
    public static function eliminar($query){
        $db = self::conn();
        $respuesta = $db->query($query);
        return $respuesta;
    }


    public static function Insert($query){
        $conexion = self::conn();
        if ($conexion){
            mysqli_set_charset($conexion,"utf8");
            if (! $result = mysqli_query($conexion, $query)) die(json_encode('DB query Error'));
            return 'success';
        }else{
            die('DB connection error');
        }
    }

    //Usefull with Login
    public static function Query($query){
        $conexion = self::conn();
        if ($conexion){
            $arreglo[] = "empty";
            mysqli_set_charset($conexion,"utf8");
            if (! $result = mysqli_query($conexion, $query)) die();
            while($data = mysqli_fetch_assoc($result)){
                $arreglo[] = $data;
//                $arreglo[0] = $data;
            }
            return $arreglo;

        }else{
            die(error);
        }
    }

}

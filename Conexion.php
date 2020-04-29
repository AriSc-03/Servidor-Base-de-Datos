 <?php

    $servidor="localhost";
 	$usuario="root";
 	$clave="";
 	$baseDeDatos="bdfloreria";

 	$enlace=mysqli_connect($servidor,$usuario,$clave,$baseDeDatos);

 	if(!$enlace){
 		echo "ERROR EN LA CONEXION DEL SERVIDOR";
 	}
 ?>
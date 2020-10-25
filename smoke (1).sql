-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2020 a las 19:44:11
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `smoke`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ganancias_producto` ()  BEGIN
DECLARE _nombre VARCHAR(255);
DECLARE _descripcion VARCHAR(255);
DECLARE _ganancia DOUBLE;
DECLARE finished INTEGER DEFAULT 0;

DECLARE ganancias_curs CURSOR FOR 
SELECT nombre, descripcion,
(precio_venta - precio_proveedor) ganancia 
FROM producto;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
CREATE TEMPORARY TABLE ganancias_producto(nombre VARCHAR(255), descripcion VARCHAR(255), ganancia DOUBLE);
OPEN ganancias_curs;
move_film: LOOP
FETCH ganancias_curs INTO _nombre, _descripcion, _ganancia;
IF finished THEN
LEAVE move_film;
END IF;
START TRANSACTION;
INSERT INTO ganancias_producto(nombre, descripcion, ganancia) VALUES (_nombre, _descripcion, _ganancia);
COMMIT;
END LOOP move_film;
CLOSE ganancias_curs;
SELECT * FROM ganancias_producto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_products` (`_imagen` VARCHAR(255), `_nombre` VARCHAR(45), `_descripcion` VARCHAR(255), `_precio_venta` DOUBLE, `_precio_proveedor` DOUBLE, `_stock` INT(11), `_stock_minimo` INT(11), `codigo_barras` VARCHAR(45))  INSERT INTO producto(nombre, imagen, descripcion, precio_venta,precio_proveedor, stock, stock_minimo, codigo_barras) VALUES (_nombre, _imagen, _descripcion, _precio_venta,_precio_proveedor, _stock, _stock_minimo, codigo_barras )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_usuario` (`_nombre` VARCHAR(15), `_email` VARCHAR(45), `_password` VARCHAR(255), `_rol` ENUM('administrador','vendedor'))  INSERT INTO usuarios (nombre, email, password, rol) VALUES (_nombre, _email, _password, _rol )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productos_agotar` ()  BEGIN
DECLARE _imagen VARCHAR(255);
DECLARE _nombre VARCHAR(255);
DECLARE _descripcion VARCHAR(255);
DECLARE _precio DOUBLE;
DECLARE _stock INTEGER;
DECLARE _stock_minimo INTEGER;
DECLARE _proveedor VARCHAR(255);
DECLARE finished INTEGER DEFAULT 0;

DECLARE agotar_curs CURSOR FOR SELECT t1.imagen, t1.nombre, t1.descripcion, 
t1.precio_venta, t1.stock, t1.stock_minimo, t3.nombre proveedor 
FROM producto t1 JOIN proveedores_has_producto t2 
ON t1.id = t2.producto_id JOIN proveedores t3 
ON t2.proveedores_id = t3.id WHERE stock <= stock_minimo;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
CREATE TEMPORARY TABLE productosAgotar(imagen VARCHAR(255), nombre VARCHAR(255), 
descripcion VARCHAR(255), precio DOUBLE, stock INTEGER, stock_minimo INTEGER, proveedor VARCHAR(255));
OPEN agotar_curs;
move_film: LOOP
FETCH agotar_curs INTO _imagen, _nombre, _descripcion, _precio, _stock, _stock_minimo, _proveedor;
IF finished THEN
LEAVE move_film;
END IF;
START TRANSACTION;
INSERT INTO productosAgotar(imagen, nombre, descripcion, precio, stock, stock_minimo, proveedor) 
VALUES (_imagen, _nombre, _descripcion, _precio, _stock, _stock_minimo, _proveedor);
COMMIT;
END LOOP move_film;
CLOSE agotar_curs;
SELECT * FROM productosAgotar;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tabla_grafica` ()  BEGIN
DECLARE _total DOUBLE;
DECLARE _mes INTEGER;
DECLARE _anio INTEGER;
DECLARE finished INTEGER DEFAULT 0;

DECLARE ventas_curs CURSOR FOR SELECT SUM(t1.importe) total, 
MONTH(t2.fecha_venta) mes, YEAR(t2.fecha_venta) anio 
FROM Producto_has_ventas t1 JOIN ventas t2 ON t1.ventas_id = t2.id 
GROUP By MONTH(t2.fecha_venta), YEAR(t2.fecha_venta)
ORDER BY YEAR(t2.fecha_venta) ASC;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
CREATE TEMPORARY TABLE new_ventasTotal(total DOUBLE, mes INT, anio INT);
OPEN ventas_curs;
move_film: LOOP
FETCH ventas_curs INTO _total, _mes, _anio;
IF finished THEN
LEAVE move_film;
END IF;
START TRANSACTION;
INSERT INTO new_ventasTotal(total, mes, anio) VALUES (_total, _mes, _anio);
COMMIT;
END LOOP move_film;
CLOSE ventas_curs;
SELECT * FROM new_ventasTotal;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tabla_temp` ()  BEGIN
DECLARE _actor_id INTEGER;
DECLARE _firSt_name VARCHAR (100);
DECLARE _last_name VARCHAR (100);
DECLARE _codigoActor VARCHAR (100);
DECLARE finished INTEGER DEFAULT 0;
DECLARE actores_curs CURSOR FOR SELECT actor_id, first_name, last_name FROM actor;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
CREATE TEMPORARY TABLE new_actor(actor_id INT, first_name VARCHAR(100), last_name VARCHAR(100), codigo VARCHAR(100));
OPEN actores_curs;
move_film: LOOP
FETCH actores_curs INTO _actor_id, _first_name, _last_name;
IF finished THEN
LEAVE move_film;
END IF;
START TRANSACTION;
SET _codigoActor = CONCAT(LPAD(_actor_id, 5, 0), SUBSTRING(_first_name, 1, 3), SUBSTRING(_last_name, 1, 3));
INSERT INTO new_actor(actor_id, first_name, last_name, codigo) VALUES (_actor_id, _first_name, _last_name, _codigoActor);
COMMIT;
END LOOP move_film;
CLOSE actores_curs;
SELECT * FROM new_actor;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id` int(11) NOT NULL,
  `tipo` enum('editado','eliminado','agregado') DEFAULT NULL,
  `fecha_mod` date DEFAULT NULL,
  `Producto_id` int(11) NOT NULL,
  `usuario` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `movimientos`
--

INSERT INTO `movimientos` (`id`, `tipo`, `fecha_mod`, `Producto_id`, `usuario`) VALUES
(1, 'agregado', '2020-06-26', 1, 'arturo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `precio_venta` double DEFAULT NULL,
  `precio_proveedor` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `stock_minimo` int(11) DEFAULT NULL,
  `codigo_barras` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `imagen`, `nombre`, `descripcion`, `precio_venta`, `precio_proveedor`, `stock`, `stock_minimo`, `codigo_barras`) VALUES
(1, 'https://images-na.ssl-images-amazon.com/images/I/510YTzJuxTL._AC_SX522_.jpg', 'Pipa cristal grande', 'pipa tintada', 30, 20, 596, 60, '25245'),
(2, 'https://www.dhresource.com/0x0/f2/albu/g6/M01/56/8F/rBVaR1sOawKAbrdNAAH01V7AUrA472.jpg', 'Pipa pyrex', 'pipa tintada de blanco', 80, 55, 17, 60, '33333333'),
(3, 'https://http2.mlstatic.com/pipa-cristal-reforzada-100pzs-30mm-hundida-D_NQ_NP_751575-MLM29155513922_012019-F.jpg', 'Pipa cristal', 'pipa tintada', 30, 18, 56, 60, '252'),
(22, 'http://localhost/smoke/imagenes/bong-plastico.jpg', 'bong', 'bonng de plastico', 80, 48, 35, 20, '1234'),
(24, 'http://localhost/smoke/imagenes/bong-para-fumar-de-cristal.jpg', 'Bong', 'Cristal', 20, 6, 8, 10, '1234555'),
(31, 'http://localhost/smoke/imagenes/incienso.jpg', 'Incieso Hem', '20 varitas', 55, 42, 15, 20, '66'),
(33, 'http://localhost/smoke/imagenes/pipa.jpg', 'pipa cristal', 'sdsdd', 120, 80, 116, 10, '252666666'),
(34, 'http://localhost/smoke/imagenes/bong-plastico.jpg', 'prueba', 'api estructura', 12, 8, 64, 20, '158469');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_has_ventas`
--

CREATE TABLE `producto_has_ventas` (
  `Producto_id` int(11) NOT NULL,
  `ventas_id` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `importe` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto_has_ventas`
--

INSERT INTO `producto_has_ventas` (`Producto_id`, `ventas_id`, `cantidad`, `importe`) VALUES
(1, 24, 1, '30.00'),
(1, 26, 1, '30.00'),
(1, 33, 2, '150.00'),
(1, 35, 2, '30.00'),
(1, 36, 1, '30.00'),
(1, 37, 4, '30.00'),
(2, 25, 1, '80.00'),
(2, 34, 2, '80.00'),
(2, 35, 1, '80.00'),
(3, 27, 2, '110.00'),
(22, 31, 2, '80.00'),
(31, 28, 3, '350.00'),
(31, 30, 1, '110.00'),
(31, 32, 3, '40.00'),
(33, 24, 1, '120.00'),
(33, 29, 5, '220.00'),
(33, 34, 1, '120.00'),
(33, 37, 2, '120.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `telefono`, `imagen`) VALUES
(1, 'Eduardo Andrade', '415-123-4567', 'https://www.tekcrispy.com/wp-content/uploads/2018/10/avatar.png'),
(2, 'David Santana', '415-167-0236', 'https://cdn.icon-icons.com/icons2/1879/PNG/512/iconfinder-3-avatar-2754579_120516.png'),
(3, 'Christian Guerrero', '415-148-62-13', 'https://www.restauracioncolectiva.com/admin/app/webroot/files/FotoNota/3322-imagen-proveedores_xavier_marcet.jpg'),
(4, 'Susana Quintana', '415-125-87-36', 'https://elempresario.mx/sites/default/files/imagecache/nota_completa/pymes_09.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores_has_producto`
--

CREATE TABLE `proveedores_has_producto` (
  `proveedores_id` int(11) NOT NULL,
  `Producto_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedores_has_producto`
--

INSERT INTO `proveedores_has_producto` (`proveedores_id`, `Producto_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 22),
(3, 24),
(3, 31),
(4, 33),
(4, 34);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol` enum('administrador','vendedor') DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `password`, `rol`, `status`) VALUES
(1, 'arturo', 'arturbau0194@gmail.com ', '$2y$10$PI2zRRRqLFZVse79cy0AgONgmZmx8fmla8Mfg.kgSaQqJFtAkEtdC', 'administrador', 1),
(2, 'Moises Gamboa', 'moises_gm9@hotmail.com', '$2y$10$L43X0RzFS6EDLdRNK.zuqOp/g1PAS3A0D1WQvcSZm6JAwX7Rx.Qje', 'vendedor', 1),
(3, 'Janete Gamboa', 'janete@gmail.com', '$2y$10$oz35TtiYnbRhMB5/pb1r9.7l6UbyXhkBciVw.t8r9Ir2qY977pxFS', 'administrador', 1),
(8, 'jose carlos', 'carlos@gmail.com', '$2y$10$gJ6AM0pYwgFCyu.ejp6fxOemZmTLHjxLwGcv.Cw/NUUAnHt6Ve8ee', 'administrador', 1),
(10, 'David Gamboa', 'david@gmail.com', '$2y$10$IT8k5VugKK79y6hI9oC75ebnvysekTagrpbee2pp2KCPgys9yQDOe', 'vendedor', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `fecha_venta` timestamp NULL DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `usuario` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `fecha_venta`, `status`, `usuario`) VALUES
(24, '2020-08-17 23:33:58', 'pagada', 'moises'),
(25, '2020-08-17 23:37:21', 'pagada', 'moises'),
(26, '2020-08-17 23:37:54', 'pagada', 'moises'),
(27, '2020-01-21 06:00:00', 'pagada', 'arturo'),
(28, '2020-03-17 06:00:00', 'pagada', 'moises'),
(29, '2020-02-04 06:00:00', 'pagada', 'arturo'),
(30, '2020-04-17 05:00:00', 'pagada', 'moises'),
(31, '2020-05-17 05:00:00', 'pagada', 'moises'),
(32, '2020-06-04 05:00:00', 'pagada', 'arturo'),
(33, '2020-07-08 05:00:00', 'pagada', 'moises'),
(34, '2020-08-17 23:47:59', 'pagada', 'moises'),
(35, '2020-08-18 01:51:43', 'pagada', 'Moises Gamboa'),
(36, '2020-08-26 18:47:21', 'pagada', 'Arturo Bautista'),
(37, '2020-08-27 04:14:36', 'pagada', 'Arturo Bautista');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_product`
--
CREATE TABLE `view_product` (
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_users`
--
CREATE TABLE `vista_users` (
`id` int(11)
,`nombre` varchar(45)
,`email` varchar(45)
,`password` varchar(255)
,`rol` enum('administrador','vendedor')
,`status` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_ventas`
--
CREATE TABLE `vista_ventas` (
`total` decimal(32,2)
,`mes` int(2)
,`anio` int(4)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `view_product`
--
DROP TABLE IF EXISTS `view_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product`  AS  select `producto`.`id` AS `id`,`producto`.`imagen` AS `imagen`,`producto`.`nombre` AS `nombre`,`producto`.`descripcion` AS `descripcion`,`producto`.`precio` AS `precio`,`producto`.`stock` AS `stock`,`producto`.`stock_minimo` AS `stock_minimo`,`producto`.`codigo_barras` AS `codigo_barras` from `producto` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_users`
--
DROP TABLE IF EXISTS `vista_users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_users`  AS  select `usuarios`.`id` AS `id`,`usuarios`.`nombre` AS `nombre`,`usuarios`.`email` AS `email`,`usuarios`.`password` AS `password`,`usuarios`.`rol` AS `rol`,`usuarios`.`status` AS `status` from `usuarios` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_ventas`
--
DROP TABLE IF EXISTS `vista_ventas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_ventas`  AS  select sum(`t1`.`importe`) AS `total`,month(`t2`.`fecha_venta`) AS `mes`,year(`t2`.`fecha_venta`) AS `anio` from (`producto_has_ventas` `t1` join `ventas` `t2` on((`t1`.`ventas_id` = `t2`.`id`))) group by month(`t2`.`fecha_venta`),year(`t2`.`fecha_venta`) order by year(`t2`.`fecha_venta`) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_movimientos_Producto1_idx` (`Producto_id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_barras` (`codigo_barras`);

--
-- Indices de la tabla `producto_has_ventas`
--
ALTER TABLE `producto_has_ventas`
  ADD PRIMARY KEY (`Producto_id`,`ventas_id`),
  ADD KEY `fk_Producto_has_ventas_ventas1_idx` (`ventas_id`),
  ADD KEY `fk_Producto_has_ventas_Producto_idx` (`Producto_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proveedores_has_producto`
--
ALTER TABLE `proveedores_has_producto`
  ADD PRIMARY KEY (`proveedores_id`,`Producto_id`),
  ADD KEY `fk_proveedores_has_Producto_Producto1_idx` (`Producto_id`),
  ADD KEY `fk_proveedores_has_Producto_proveedores1_idx` (`proveedores_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ventas_usuarios1_idx` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD CONSTRAINT `fk_movimientos_Producto1` FOREIGN KEY (`Producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `producto_has_ventas`
--
ALTER TABLE `producto_has_ventas`
  ADD CONSTRAINT `fk_Producto_has_ventas_Producto` FOREIGN KEY (`Producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Producto_has_ventas_ventas1` FOREIGN KEY (`ventas_id`) REFERENCES `ventas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedores_has_producto`
--
ALTER TABLE `proveedores_has_producto`
  ADD CONSTRAINT `fk_proveedores_has_Producto_Producto1` FOREIGN KEY (`Producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_proveedores_has_Producto_proveedores1` FOREIGN KEY (`proveedores_id`) REFERENCES `proveedores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

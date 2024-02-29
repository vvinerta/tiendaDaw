-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: basedatos
-- Tiempo de generación: 07-02-2024 a las 18:44:33
-- Versión del servidor: 10.6.16-MariaDB-1:10.6.16+maria~ubu2004
-- Versión de PHP: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdd_tienda_daw`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `id_usuario_creador_id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `id_usuario_creador_id`, `codigo`) VALUES
(1, 2, 'camisetas'),
(2, 2, 'vaqueros'),
(3, 2, 'sudaderas'),
(4, 2, 'cazadoras');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_idiomas`
--

CREATE TABLE `categorias_idiomas` (
  `id` int(11) NOT NULL,
  `id_categoria_id` int(11) NOT NULL,
  `id_idioma_id` int(11) NOT NULL,
  `nombre_categoria` varchar(50) NOT NULL,
  `desc_categoria` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias_idiomas`
--

INSERT INTO `categorias_idiomas` (`id`, `id_categoria_id`, `id_idioma_id`, `nombre_categoria`, `desc_categoria`) VALUES
(1, 4, 1, 'Cazadoras', 'Cazadoras para todas las ocasiones y condiciones'),
(2, 3, 1, 'Sudaderas', 'Sudaderas con una amplia selección de colores y diseños'),
(3, 2, 1, 'Vaqueros', 'Pantalones vaqueros comodos adecuados para todos los estilos'),
(4, 1, 1, 'Camisetas', 'Camisetas de manga corta larga y tirantes'),
(5, 1, 2, 'T-shirts', 'Short-sleeved, long-sleeved, and tank top T-shirts'),
(6, 2, 2, 'Jeans', ' Comfortable jeans suitable for all styles'),
(7, 3, 2, 'Sweatshirts', ' Sweatshirts with a wide selection of colors and designs'),
(8, 4, 2, 'Jackets', ' Jackets for all occasions and conditions');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `id_usuario_id` int(11) NOT NULL,
  `id_producto_id` int(11) NOT NULL,
  `comentario` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `id_usuario_id` int(11) NOT NULL,
  `fecha_realizada` varchar(50) NOT NULL,
  `precio_total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `id_usuario_id`, `fecha_realizada`, `precio_total`) VALUES
(2, 2, '2024-02-07 18:41:11', 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_pedidos`
--

CREATE TABLE `detalles_pedidos` (
  `id` int(11) NOT NULL,
  `id_compra_id` int(11) NOT NULL,
  `id_producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalles_pedidos`
--

INSERT INTO `detalles_pedidos` (`id`, `id_compra_id`, `id_producto_id`, `cantidad`) VALUES
(2, 2, 1, 5);

--
-- Disparadores `detalles_pedidos`
--
DELIMITER $$
CREATE TRIGGER `updateCantProductos` AFTER INSERT ON `detalles_pedidos` FOR EACH ROW BEGIN
    DECLARE producto_id INT;
    DECLARE nueva_cantidad INT;
    
    -- Obtener el id del producto y la nueva cantidad desde la fila que se está insertando
    SET producto_id = NEW.id_producto_id;
    SET nueva_cantidad = NEW.cantidad;
    
    -- Actualizar la cantidad de productos en la tabla de productos
    UPDATE productos
    SET stock = stock - nueva_cantidad
    WHERE id = producto_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20240206154437', '2024-02-06 15:44:43', 464);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idiomas`
--

CREATE TABLE `idiomas` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `idiomas`
--

INSERT INTO `idiomas` (`id`, `codigo`, `nombre`) VALUES
(1, 'ESP', 'español'),
(2, 'ENG', 'english');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `id_categoria_id` int(11) NOT NULL,
  `id_usuario_creador_id` int(11) NOT NULL,
  `precio` double NOT NULL,
  `stock` int(11) NOT NULL,
  `imagen_producto` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `id_categoria_id`, `id_usuario_creador_id`, `precio`, `stock`, `imagen_producto`) VALUES
(1, 1, 2, 9.99, 15, 'http://localhost:8000/img/camiseta1.jpg'),
(2, 1, 2, 15.99, 30, 'http://localhost:8000/img/camiseta2.jpg'),
(3, 1, 2, 14.99, 40, 'http://localhost:8000/img/camiseta3.jpg'),
(4, 1, 2, 9.99, 26, 'http://localhost:8000/img/camiseta4.jpg'),
(5, 2, 2, 39.99, 56, 'http://localhost:8000/img/vaqueros1.jpg'),
(6, 2, 2, 49.99, 53, 'http://localhost:8000/img/vaqueros2.jpg'),
(7, 2, 2, 44.99, 18, 'http://localhost:8000/img/vaqueros3.jpg'),
(8, 2, 2, 39.99, 24, 'http://localhost:8000/img/vaqueros4.jpg'),
(9, 3, 2, 29.99, 25, 'http://localhost:8000/img/sudadera1.jpg'),
(10, 3, 2, 34.99, 87, 'http://localhost:8000/img/sudadera2.jpg'),
(11, 3, 2, 27.99, 53, 'http://localhost:8000/img/sudadera3.jpg'),
(12, 3, 2, 19.99, 53, 'http://localhost:8000/img/sudadera4.jpg'),
(13, 4, 2, 2800, 36, 'http://localhost:8000/img/cazadora1.jpg'),
(14, 4, 2, 59.9, 31, 'http://localhost:8000/img/cazadora2.jpg'),
(15, 4, 2, 150, 22, 'http://localhost:8000/img/cazadora3.jpg'),
(16, 4, 2, 199.99, 132, 'http://localhost:8000/img/cazadora4.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_idiomas`
--

CREATE TABLE `productos_idiomas` (
  `id` int(11) NOT NULL,
  `id_prodcuto_id` int(11) NOT NULL,
  `id_idioma_id` int(11) NOT NULL,
  `nombre_producto` varchar(100) NOT NULL,
  `desc_producto` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos_idiomas`
--

INSERT INTO `productos_idiomas` (`id`, `id_prodcuto_id`, `id_idioma_id`, `nombre_producto`, `desc_producto`) VALUES
(1, 1, 1, 'Camiseta simple', 'Camiseta sin adornos y de colores basicos'),
(2, 2, 1, 'Camiseta estampada', 'Camiseta de manga corta con estampado colorido y moderno'),
(3, 3, 1, 'Camiseta de rayas', 'Camiseta a rayas en tonos azules y blancos perfecta para un look casual'),
(4, 4, 1, 'Camiseta de manga larga', 'Camiseta sin adornos y de colores basicos'),
(5, 1, 2, 'Simple T-shirt', 'Plain T-shirt in basic colors without decorations'),
(6, 2, 2, 'Printed T-shirt', 'Short-sleeved T-shirt with colorful and modern print'),
(7, 3, 2, 'Striped T-shirt', 'Blue and white striped T-shirt perfect for a casual look'),
(8, 4, 2, 'Long-sleeve T-shirt', 'Plain long-sleeve T-shirt in basic colors'),
(9, 5, 1, 'Vaqueros clásicos azules', 'Vaqueros de mezclilla clásicos en tono azul corte recto y duraderos'),
(10, 6, 1, 'Vaqueros desgastados', 'Vaqueros de mezclilla con efecto desgastado y estilo moderno'),
(11, 7, 1, 'Vaqueros negros ajustados', 'Vaqueros de mezclilla negra corte ajustado y diseño contemporáneo'),
(12, 8, 1, 'Vaqueros rotos', 'Vaqueros rotos ajustados disponibles en todos los colores basicos'),
(13, 5, 2, 'Classic Blue Jeans', 'Classic straight-cut denim jeans in blue, durable and stylish'),
(14, 6, 2, 'Distressed Jeans', 'Denim jeans with a distressed effect and modern style'),
(15, 7, 2, 'Skinny Black Jeans', 'Black skinny jeans with a contemporary design'),
(16, 8, 2, 'Ripped Jeans', 'Tight ripped jeans available in all basic colors'),
(17, 9, 1, 'Sudadera con capucha clásica', 'Sudadera con capucha de algodón clásica en color gris perfecta para un look casual y cómodo'),
(18, 10, 1, 'Sudadera estampada', 'Sudadera con estampado moderno y llamativo ideal para lucir a la moda en cualquier ocasión'),
(19, 11, 1, 'Sudadera de cuelo redondo', 'Sudadera de cuello redondo en tono azul marino confeccionada en material suave y confortable'),
(20, 12, 1, 'Sudadera con cremallera', 'Sudadera de algodon clásica disponible en colores clasicos'),
(21, 9, 2, 'Classic Hoodie', 'Classic cotton hoodie in gray, perfect for a casual and comfortable look'),
(22, 10, 2, 'Printed Hoodie', 'Modern and eye-catching printed hoodie, ideal for a fashionable look on any occasion'),
(23, 11, 2, 'Round Neck Sweatshirt', 'Navy blue round-neck sweatshirt made of soft and comfortable material'),
(24, 12, 2, 'Zip-up Sweatshirt', 'Classic cotton zip-up sweatshirt available in classic colors'),
(25, 13, 1, 'Cazadora vaquera gris', 'Cazadora de tejido vaquero aterciopelado en color gris'),
(26, 14, 1, 'Cazadora vaquera azul', 'Cazadora vaquera azul con costuras'),
(27, 15, 1, 'Cazadora de cuero negro', 'Cazadora de cuero genuino en color negro'),
(28, 16, 1, 'Cazadora de biker', 'Cazadora de cuero negro'),
(29, 13, 2, 'Gray Denim Jacket', 'Velvet denim jacket in gray'),
(30, 14, 2, 'Blue Denim Jacket', 'Blue denim jacket with seams'),
(31, 15, 2, 'Black Leather Jacket', 'Genuine black leather jacket'),
(32, 16, 2, 'Biker Jacket', 'Black leather biker jacket');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`) VALUES
(2, 'admin@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$OoHR.FDFTcM03e6g4pCz/eTjGccwE/a23XOJnMcXV2c3TjscICXfC');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5E9F836C12E6F430` (`id_usuario_creador_id`);

--
-- Indices de la tabla `categorias_idiomas`
--
ALTER TABLE `categorias_idiomas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_33443AA410560508` (`id_categoria_id`),
  ADD KEY `IDX_33443AA45EE9BA36` (`id_idioma_id`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F54B3FC07EB2C349` (`id_usuario_id`),
  ADD KEY `IDX_F54B3FC06E57A479` (`id_producto_id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_3692E1B77EB2C349` (`id_usuario_id`);

--
-- Indices de la tabla `detalles_pedidos`
--
ALTER TABLE `detalles_pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_AFDEA95472D2B8F0` (`id_compra_id`),
  ADD KEY `IDX_AFDEA9546E57A479` (`id_producto_id`);

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `idiomas`
--
ALTER TABLE `idiomas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_767490E610560508` (`id_categoria_id`),
  ADD KEY `IDX_767490E612E6F430` (`id_usuario_creador_id`);

--
-- Indices de la tabla `productos_idiomas`
--
ALTER TABLE `productos_idiomas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_2ABBAA61BFD6EC0B` (`id_prodcuto_id`),
  ADD KEY `IDX_2ABBAA615EE9BA36` (`id_idioma_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `categorias_idiomas`
--
ALTER TABLE `categorias_idiomas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalles_pedidos`
--
ALTER TABLE `detalles_pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `idiomas`
--
ALTER TABLE `idiomas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `productos_idiomas`
--
ALTER TABLE `productos_idiomas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD CONSTRAINT `FK_5E9F836C12E6F430` FOREIGN KEY (`id_usuario_creador_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `categorias_idiomas`
--
ALTER TABLE `categorias_idiomas`
  ADD CONSTRAINT `FK_33443AA410560508` FOREIGN KEY (`id_categoria_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `FK_33443AA45EE9BA36` FOREIGN KEY (`id_idioma_id`) REFERENCES `idiomas` (`id`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `FK_F54B3FC06E57A479` FOREIGN KEY (`id_producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `FK_F54B3FC07EB2C349` FOREIGN KEY (`id_usuario_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `FK_3692E1B77EB2C349` FOREIGN KEY (`id_usuario_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `detalles_pedidos`
--
ALTER TABLE `detalles_pedidos`
  ADD CONSTRAINT `FK_AFDEA9546E57A479` FOREIGN KEY (`id_producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `FK_AFDEA95472D2B8F0` FOREIGN KEY (`id_compra_id`) REFERENCES `compras` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `FK_767490E610560508` FOREIGN KEY (`id_categoria_id`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `FK_767490E612E6F430` FOREIGN KEY (`id_usuario_creador_id`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `productos_idiomas`
--
ALTER TABLE `productos_idiomas`
  ADD CONSTRAINT `FK_2ABBAA615EE9BA36` FOREIGN KEY (`id_idioma_id`) REFERENCES `idiomas` (`id`),
  ADD CONSTRAINT `FK_2ABBAA61BFD6EC0B` FOREIGN KEY (`id_prodcuto_id`) REFERENCES `productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

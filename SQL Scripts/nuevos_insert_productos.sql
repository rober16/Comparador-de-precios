use super_vea
go

INSERT INTO productos (cod_barra, nom_producto, desc_producto, nro_categoria, imagen, nro_marca, nro_tipo_producto, vigente) VALUES
-- Pan (Categoría 1)
(10000011, 'Pan de Hamburguesa', 'Pan para hamburguesas clásico', 1, 'assets/productos/pan_hamburguesa.jpg', 1, 7, 1),
(10000012, 'Pan Árabe', 'Pan árabe tradicional', 1, 'assets/productos/pan_arabe.jpg', 9, 7, 1),
-- Galletitas (Categoría 2)
(10000013, 'Galletitas de Arroz', 'Galletitas de arroz integral', 2, 'assets/productos/galletas_arroz.jpg', 6, 2, 1),
(10000014, 'Oreo', 'Galletitas rellenas de vainilla', 2, 'assets/productos/oreo.jpg', 4, 7, 1),
-- Arroz (Categoría 3)
(10000015, 'Arroz Yamaní', 'Arroz yamaní integral', 3, 'assets/productos/arroz_yamani.jpg', 7, 1, 1),
-- Legumbres (Categoría 8)
(20000003, 'Garbanzos', 'Garbanzos secos', 8, 'assets/productos/garbanzos.jpg', 17, 2, 1),
(20000004, 'Porotos Alubia', 'Porotos blancos secos', 8, 'assets/productos/porotos_alubia.jpg', 18, 7, 1),
-- Leche (Categoría 14)
(40000008, 'Leche Chocolatada', 'Leche con chocolate', 14, 'assets/productos/leche_chocolatada.jpg', 26, 7, 1),
-- Queso (Categoría 15)
(40000009, 'Queso Mozzarella', 'Queso mozzarella en barra', 15, 'assets/productos/queso_mozzarella.jpg', 28, 7, 1),
(40000010, 'Ricotta', 'Ricotta light', 15, 'assets/productos/ricotta.jpg', 26, 3, 1),
-- Bebidas edulcoradas (Categoría 19)
(70000009, 'Sprite', 'Gaseosa lima-limón', 19, 'assets/productos/sprite.jpg', 41, 7, 1),
-- Bebidas no edulcoradas (Categoría 20)
(70000010, 'Agua Saborizada', 'Agua sabor pomelo', 20, 'assets/productos/agua_saborizada.jpg', 41, 3, 1),
-- Café (Categoría 21)
(70000011, 'Café Molido Torrado', 'Café molido suave', 21, 'assets/productos/cafe_torrado.jpg', 45, 7, 1);

select * from productos


-- --------------------------------------------------------------------------------------------------
-- PARA SUPERMERCADO CARACOL
-- --------------------------------------------------------------------------------------------------
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
-- Sucursal 1
(1, '10000011', 1250.00, 1),  -- Pan de Hamburguesa (Bimbo)
(1, '10000012', 980.00, 1),   -- Pan Árabe (Dos Hermanos)
(1, '10000013', 850.00, 1),   -- Galletitas de Arroz (Granix)
(1, '10000014', 1750.00, 1),  -- Oreo (Bagley)
(1, '10000015', 1200.00, 1),  -- Arroz Yamaní (Gallo)
-- Sucursal 2
(2, '10000011', 1300.00, 1),
(2, '10000012', 1050.00, 1),
(2, '10000013', 900.00, 1),
(2, '10000014', 1800.00, 1),
(2, '10000015', 1250.00, 1),
-- Sucursal 1
(1, '20000003', 950.00, 1),   -- Garbanzos (Arcor)
(1, '20000004', 1100.00, 1),  -- Porotos Alubia (La Campagnola)
-- Sucursal 3
(3, '20000003', 1000.00, 1),
(3, '20000004', 1150.00, 1),
-- Sucursal 1
(1, '40000008', 980.00, 1),   -- Leche Chocolatada (La Serenísima)
(1, '40000009', 2200.00, 1),  -- Queso Mozzarella (Ilolay)
(1, '40000010', 1500.00, 1),  -- Ricotta Light (La Serenísima)
-- Sucursal 4
(4, '40000008', 1050.00, 1),
(4, '40000009', 2300.00, 1),
(4, '40000010', 1550.00, 1),
-- Sucursal 1
(1, '70000009', 850.00, 1),   -- Sprite (Coca-Cola)
(1, '70000010', 650.00, 1),   -- Agua Saborizada (Coca-Cola)
(1, '70000011', 3200.00, 1),  -- Café Torrado (La Virginia)
-- Sucursal 5
(5, '70000009', 880.00, 1),
(5, '70000010', 680.00, 1),
(5, '70000011', 3350.00, 1),
-- Sucursal 1
(1, '50000001', 1800.00, 1),  -- Aceite de Girasol (Natura)
-- Sucursal 7
(7, '50000001', 1850.00, 1);

-- --------------------------------------------------------------------------------------------------
-- PARA SUPERMERCADO DISCO
-- --------------------------------------------------------------------------------------------------

-- Sucursal 1 (Localidad 9 - Río Ceballos)
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(1, '10000011', 1350.00, 1),  -- Pan de Hamburguesa
(1, '10000012', 1100.00, 1),   -- Pan Árabe
(1, '10000013', 920.00, 1),    -- Galletitas de Arroz
(1, '10000014', 1890.00, 1),   -- Oreo
(1, '10000015', 1280.00, 1),   -- Arroz Yamaní
(1, '20000003', 1050.00, 1),   -- Garbanzos
(1, '20000004', 1180.00, 1),   -- Porotos Alubia
(1, '40000008', 1020.00, 1),   -- Leche Chocolatada
(1, '40000009', 2350.00, 1),   -- Queso Mozzarella
(1, '40000010', 1580.00, 1),   -- Ricotta Light
(1, '70000009', 890.00, 1),    -- Sprite
(1, '70000010', 690.00, 1),    -- Agua Saborizada
(1, '70000011', 3380.00, 1);   -- Café Torrado

-- Sucursal 2 (Localidad 9 - Río Ceballos)
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(2, '10000011', 1400.00, 1),   -- Pan de Hamburguesa
(2, '10000012', 1150.00, 1),   -- Pan Árabe
(2, '10000013', 950.00, 1),    -- Galletitas de Arroz
(2, '10000014', 1950.00, 1),   -- Oreo
(2, '10000015', 1320.00, 1),   -- Arroz Yamaní
(2, '20000003', 1080.00, 1),   -- Garbanzos
(2, '20000004', 1220.00, 1),   -- Porotos Alubia
(2, '40000008', 1050.00, 1),   -- Leche Chocolatada
(2, '40000009', 2450.00, 1),   -- Queso Mozzarella
(2, '40000010', 1620.00, 1),   -- Ricotta Light
(2, '70000009', 920.00, 1),    -- Sprite
(2, '70000010', 720.00, 1),    -- Agua Saborizada
(2, '70000011', 3450.00, 1);   -- Café Torrado

-- Sucursal 3 (Localidad 9 - Río Ceballos)
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(3, '10000011', 1380.00, 1),   -- Pan de Hamburguesa
(3, '10000012', 1120.00, 1),   -- Pan Árabe
(3, '10000013', 980.00, 1),    -- Galletitas de Arroz
(3, '10000014', 1920.00, 1),   -- Oreo
(3, '10000015', 1300.00, 1),   -- Arroz Yamaní
(3, '20000003', 1100.00, 1),   -- Garbanzos
(3, '20000004', 1250.00, 1),   -- Porotos Alubia
(3, '40000008', 1080.00, 1),   -- Leche Chocolatada
(3, '40000009', 2400.00, 1),   -- Queso Mozzarella
(3, '40000010', 1650.00, 1),   -- Ricotta Light
(3, '70000009', 950.00, 1),    -- Sprite
(3, '70000010', 750.00, 1),    -- Agua Saborizada
(3, '70000011', 3500.00, 1);   -- Café Torrado

-- Sucursal 4 (Localidad 9 - Río Ceballos)
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(4, '10000011', 1420.00, 1),   -- Pan de Hamburguesa
(4, '10000012', 1180.00, 1),   -- Pan Árabe
(4, '10000013', 1000.00, 1),   -- Galletitas de Arroz
(4, '10000014', 1980.00, 1),   -- Oreo
(4, '10000015', 1350.00, 1),   -- Arroz Yamaní
(4, '20000003', 1150.00, 1),   -- Garbanzos
(4, '20000004', 1300.00, 1),   -- Porotos Alubia
(4, '40000008', 1120.00, 1),   -- Leche Chocolatada
(4, '40000009', 2500.00, 1),   -- Queso Mozzarella
(4, '40000010', 1700.00, 1),   -- Ricotta Light
(4, '70000009', 980.00, 1),    -- Sprite
(4, '70000010', 780.00, 1),    -- Agua Saborizada
(4, '70000011', 3550.00, 1);   -- Café Torrado

-- Sucursal 5 (Localidad 9 - Río Ceballos)
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(5, '10000011', 1450.00, 1),   -- Pan de Hamburguesa
(5, '10000012', 1200.00, 1),   -- Pan Árabe
(5, '10000013', 1050.00, 1),   -- Galletitas de Arroz
(5, '10000014', 2050.00, 1),   -- Oreo
(5, '10000015', 1400.00, 1),   -- Arroz Yamaní
(5, '20000003', 1200.00, 1),   -- Garbanzos
(5, '20000004', 1350.00, 1),   -- Porotos Alubia
(5, '40000008', 1150.00, 1),   -- Leche Chocolatada
(5, '40000009', 2550.00, 1),   -- Queso Mozzarella
(5, '40000010', 1750.00, 1),   -- Ricotta Light
(5, '70000009', 1000.00, 1),   -- Sprite
(5, '70000010', 800.00, 1),    -- Agua Saborizada
(5, '70000011', 3600.00, 1);   -- Café Torrado

-- --------------------------------------------------------------------------------------------------
-- PARA SUPERMERCADO LIBERTAD
-- --------------------------------------------------------------------------------------------------
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(1, '10000011', 1390.00, 1),  -- Pan de Hamburguesa (↑)
(1, '10000012', 1050.00, 1),  -- Pan Árabe (↓)
(1, '10000013', 950.00, 1),   -- Galletitas de Arroz (↑)
(1, '10000014', 1820.00, 1),  -- Oreo (↓)
(1, '10000015', 1330.00, 1),  -- Arroz Yamaní (↑)
(1, '20000003', 990.00, 1),   -- Garbanzos (↓)
(1, '20000004', 1240.00, 1),  -- Porotos Alubia (↑)
(1, '40000008', 970.00, 1),   -- Leche Chocolatada (↓)
(1, '40000009', 2420.00, 1),  -- Queso Mozzarella (↑)
(1, '40000010', 1500.00, 1),  -- Ricotta Light (↓)
(1, '70000009', 910.00, 1),   -- Sprite (↑)
(1, '70000010', 670.00, 1),   -- Agua Saborizada (↓)
(1, '70000011', 3480.00, 1);  -- Café Torrado (↑)
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(2, '10000011', 1350.00, 1),  -- ↓
(2, '10000012', 1200.00, 1),  -- ↑
(2, '10000013', 980.00, 1),   -- ↑
(2, '10000014', 1890.00, 1),  -- ↓
(2, '10000015', 1250.00, 1),  -- ↓
(2, '20000003', 1150.00, 1),  -- ↑
(2, '20000004', 1180.00, 1),  -- ↓
(2, '40000008', 1110.00, 1),  -- ↑
(2, '40000009', 2320.00, 1),  -- ↓
(2, '40000010', 1690.00, 1),  -- ↑
(2, '70000009', 890.00, 1),   -- ↓
(2, '70000010', 740.00, 1),   -- ↑
(2, '70000011', 3370.00, 1);  -- ↓
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(3, '10000011', 1410.00, 1),  -- ↑
(3, '10000012', 1080.00, 1),  -- ↓
(3, '10000013', 960.00, 1),   -- ↓
(3, '10000014', 2000.00, 1),  -- ↑
(3, '10000015', 1270.00, 1),  -- ↓
(3, '20000003', 1160.00, 1),  -- ↑
(3, '20000004', 1220.00, 1),  -- ↓
(3, '40000008', 1120.00, 1),  -- ↑
(3, '40000009', 2350.00, 1),  -- ↓
(3, '40000010', 1680.00, 1),  -- ↑
(3, '70000009', 930.00, 1),   -- ↓
(3, '70000010', 770.00, 1),   -- ↑
(3, '70000011', 3400.00, 1);  -- ↓
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(4, '10000011', 1390.00, 1),  -- ↓
(4, '10000012', 1220.00, 1),  -- ↑
(4, '10000013', 970.00, 1),   -- ↓
(4, '10000014', 2020.00, 1),  -- ↑
(4, '10000015', 1370.00, 1),  -- ↑
(4, '20000003', 1100.00, 1),  -- ↓
(4, '20000004', 1320.00, 1),  -- ↑
(4, '40000008', 1160.00, 1),  -- ↑
(4, '40000009', 2430.00, 1),  -- ↓
(4, '40000010', 1680.00, 1),  -- ↓
(4, '70000009', 990.00, 1),   -- ↑
(4, '70000010', 760.00, 1),   -- ↓
(4, '70000011', 3650.00, 1);  -- ↑
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(5, '10000011', 1480.00, 1),  -- ↑
(5, '10000012', 1180.00, 1),  -- ↓
(5, '10000013', 1070.00, 1),  -- ↑
(5, '10000014', 1980.00, 1),  -- ↓
(5, '10000015', 1380.00, 1),  -- ↓
(5, '20000003', 1250.00, 1),  -- ↑
(5, '20000004', 1320.00, 1),  -- ↓
(5, '40000008', 1130.00, 1),  -- ↓
(5, '40000009', 2600.00, 1),  -- ↑
(5, '40000010', 1780.00, 1),  -- ↑
(5, '70000009', 980.00, 1),   -- ↓
(5, '70000010', 820.00, 1),   -- ↑
(5, '70000011', 3550.00, 1);  -- ↓


-- --------------------------------------------------------------------------------------------------
-- PARA SUPERMERCADO VEA
-- --------------------------------------------------------------------------------------------------
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(1, '10000011', 1390.00, 1),
(1, '10000012', 1100.00, 1),
(1, '10000013', 980.00, 1),
(1, '10000014', 1900.00, 1),
(1, '10000015', 1300.00, 1),
(1, '20000003', 1120.00, 1),
(1, '20000004', 1200.00, 1),
(1, '40000008', 1150.00, 1),
(1, '40000009', 2400.00, 1),
(1, '40000010', 1650.00, 1),
(1, '70000009', 950.00, 1),
(1, '70000010', 750.00, 1),
(1, '70000011', 3500.00, 1);
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(2, '10000011', 1420.00, 1),
(2, '10000012', 1150.00, 1),
(2, '10000013', 950.00, 1),
(2, '10000014', 1950.00, 1),
(2, '10000015', 1280.00, 1),
(2, '20000003', 1170.00, 1),
(2, '20000004', 1250.00, 1),
(2, '40000008', 1180.00, 1),
(2, '40000009', 2450.00, 1),
(2, '40000010', 1680.00, 1),
(2, '70000009', 970.00, 1),
(2, '70000010', 770.00, 1),
(2, '70000011', 3450.00, 1);
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(3, '10000011', 1350.00, 1),
(3, '10000012', 1120.00, 1),
(3, '10000013', 1000.00, 1),
(3, '10000014', 1880.00, 1),
(3, '10000015', 1320.00, 1),
(3, '20000003', 1100.00, 1),
(3, '20000004', 1220.00, 1),
(3, '40000008', 1120.00, 1),
(3, '40000009', 2390.00, 1),
(3, '40000010', 1700.00, 1),
(3, '70000009', 940.00, 1),
(3, '70000010', 730.00, 1),
(3, '70000011', 3550.00, 1);
INSERT INTO productos_sucursales (nro_sucursal, cod_barra, precio, vigente) VALUES
(4, '10000011', 1440.00, 1),
(4, '10000012', 1130.00, 1),
(4, '10000013', 970.00, 1),
(4, '10000014', 1930.00, 1),
(4, '10000015', 1350.00, 1),
(4, '20000003', 1150.00, 1),
(4, '20000004', 1270.00, 1),
(4, '40000008', 1140.00, 1),
(4, '40000009', 2500.00, 1),
(4, '40000010', 1720.00, 1),
(4, '70000009', 960.00, 1),
(4, '70000010', 790.00, 1),
(4, '70000011', 3600.00, 1);

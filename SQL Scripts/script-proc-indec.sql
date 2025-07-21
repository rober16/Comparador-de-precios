use indec
go

----------------------------------------------------------------------------------------------------
-- Seccion Sucursales
----------------------------------------------------------------------------------------------------

/*Get sucursales por localidad*/
create or alter procedure dbo.get_sucursales
(
	@nro_localidad integer
)
as
begin
  select nroSupermercado = nro_supermercado,
         nroSucursal = nro_sucursal,
         nomSucursal = nom_sucursal,
         calle = calle,
         nroCalle = nro_calle,
         telefonos = telefonos,
         coordLatitud = coord_latitud,
         coordLongitud = coord_longitud,
         horarioSucursal = horario_sucursal,
         serviciosDisponibles = servicios_disponibles,
         nroLocalidad = nro_localidad,
         habilitada = habilitada
    from dbo.sucursales (nolock)
	where nro_localidad = @nro_localidad
	and habilitada = 1
   order by nro_sucursal
end
go

create or alter procedure dbo.get_provincias
as
begin

  select codProvincia = cod_provincia,
         nomProvincia = nom_provincia
    from dbo.provincias (nolock)
   order by nom_provincia

end
go

create or alter procedure dbo.get_localidades
(
    @cod_provincia	varchar(3) = null
)
as
begin
  select nroLocalidad = nro_localidad,
         nomLocalidad = nom_localidad,
		 codPais      = cod_pais,
		 codProvincia = cod_provincia
    from dbo.localidades (nolock)
   where (cod_provincia = @cod_provincia or @cod_provincia is null)
   order by nro_localidad   
end
go



----------------------------------------------------------------------------------------------------
-- Seccion Productos
----------------------------------------------------------------------------------------------------

--execute get_rubros @cod_idioma = 2
create or alter procedure dbo.get_rubros
(
	@cod_idioma integer
)
as
begin

  select nroRubro = nro_rubro,
         nomRubro = rubro
    from dbo.idioma_rubros_productos (nolock)
	where cod_idioma = @cod_idioma
   order by rubro
end
go

--execute get_categorias @nro_rubro = 1 , @cod_idioma = 1
create or alter procedure dbo.get_categorias
(
	@nro_rubro INTEGER,
	@cod_idioma integer
)
as
begin
  select nroCategoria = icp.nro_categoria,
         nomCategoria = icp.categoria,
		 nroRubro = cp.nro_rubro
    from dbo.categorias_productos cp (nolock)
	join dbo.idiomas_categorias_productos icp
	on cp.nro_categoria = icp.nro_categoria
	where cp.nro_rubro = @nro_rubro and icp.cod_idioma = @cod_idioma
   order by nroCategoria
end
go


create or alter procedure dbo.get_productos
as
begin
    select 
        codBarra = p.cod_barra,
        nomProducto = p.nom_producto,
        nomMarca = m.nom_marca,
        imagen = p.imagen
    from 
        productos p
    inner join 
        marcas_productos m on p.nro_marca = m.nro_marca
    where 
        p.vigente = 1 
        and m.vigente = 1
    order by 
        p.nom_producto;
end
go

-- execute get_marcas
create or alter procedure dbo.get_marcas
as
begin

  select nroMarca = nro_marca,
         nomMarca = nom_marca
    from dbo.marcas_productos (nolock)
   order by nom_marca

end
go

-- execute get_tipos_productos @cod_idioma = 2
create or alter procedure dbo.get_tipos_productos
(
	@cod_idioma integer
)
as
begin

  select nroTipoProducto = nro_tipo_producto,
         nomTipoProducto = tipo_producto
    from dbo.idiomas_tipos_productos (nolock)
	where cod_idioma = @cod_idioma
   order by tipo_producto
end
go


--execute comparar_precios @nro_localidad = 1, @cod_barras = '10000001, 10000002'
--execute comparar_precios @nro_localidad = 1, @cod_barras = '50000001,60000001,70000001,60000002'

CREATE OR ALTER PROCEDURE comparar_precios
    @nro_localidad INT,
    @cod_barras VARCHAR(MAX)
AS
BEGIN
    -- Convertir la cadena de códigos de barra en una tabla
    DECLARE @Barras TABLE (cod_barra VARCHAR(13));
    INSERT INTO @Barras (cod_barra)
    SELECT value FROM STRING_SPLIT(@cod_barras, ',');

    -- Tabla para productos desactualizados por supermercado
    DECLARE @ProductosDesactualizados TABLE (
        cod_barra VARCHAR(13),
        nom_producto VARCHAR(255),
		imagen VARCHAR(255),
        nro_supermercado INT,
        nom_supermercado VARCHAR(255),
        motivo VARCHAR(50)
    );
    
    -- Identificar productos desactualizados (no tienen datos del día actual)
    INSERT INTO @ProductosDesactualizados
    SELECT 
        p.cod_barra,
        p.nom_producto,
		p.imagen,
        s.nro_supermercado,
        s.razon_social,
        'Precio no actualizado hoy'
    FROM productos p
    CROSS JOIN supermercados s
    JOIN sucursales suc ON s.nro_supermercado = suc.nro_supermercado
    WHERE p.cod_barra IN (SELECT cod_barra FROM @Barras)
    AND p.vigente = 1
    AND suc.nro_localidad = @nro_localidad
    AND NOT EXISTS (
        SELECT 1 
        FROM productos_supermercados ps
        WHERE ps.cod_barra = p.cod_barra
        AND ps.nro_supermercado = s.nro_supermercado
        AND ps.fecha_ult_actualizacion = CAST(GETDATE() AS DATE)
    );

    -- CTE para productos con precios actualizados (hoy)
    WITH ProductosActualizados AS (
        SELECT
            p.cod_barra,
            p.nom_producto,
            p.imagen,
            ps.nro_supermercado,
            ps.nro_sucursal,
            ps.precio,
            ps.fecha_ult_actualizacion
        FROM
            productos p
        JOIN
            productos_supermercados ps ON p.cod_barra = ps.cod_barra
        JOIN
            sucursales suc ON ps.nro_supermercado = suc.nro_supermercado 
                          AND ps.nro_sucursal = suc.nro_sucursal
        WHERE
            suc.nro_localidad = @nro_localidad 
            AND p.cod_barra IN (SELECT cod_barra FROM @Barras) 
            AND p.vigente = 1
            AND ps.fecha_ult_actualizacion = CAST(GETDATE() AS DATE)
    ),
    ProductosSupermercado AS (
        SELECT
            pa.cod_barra AS codBarra,
            pa.nom_producto AS nomProducto,
            pa.imagen,
            s.nro_supermercado AS nroSupermercado,
            s.razon_social AS nomSupermercado,
            MIN(pa.precio) AS precio,
            0 AS esDesactualizado -- Marcador para productos actualizados
        FROM
            ProductosActualizados pa
        JOIN
            supermercados s ON pa.nro_supermercado = s.nro_supermercado
        GROUP BY
            pa.cod_barra, pa.nom_producto, pa.imagen, s.nro_supermercado, s.razon_social
    ),
    -- Agregar productos desactualizados al conjunto de resultados
    ProductosCompletos AS (
        SELECT 
            codBarra, nomProducto, imagen, nroSupermercado, nomSupermercado, precio,
            esDesactualizado
        FROM ProductosSupermercado
        
        UNION ALL
        
        SELECT 
            cod_barra AS codBarra,
            nom_producto AS nomProducto,
            imagen AS imagen, -- No tenemos imagen en la tabla de desactualizados
            nro_supermercado AS nroSupermercado,
            nom_supermercado AS nomSupermercado,
            NULL AS precio, -- No tenemos precio actualizado
            1 AS esDesactualizado -- Marcador para productos desactualizados
        FROM @ProductosDesactualizados
    ),
    -- CTE para contar productos por supermercado (solo los actualizados)
    ConteoProductos AS (
        SELECT
            ps.nomSupermercado,
            COUNT(DISTINCT CASE WHEN ps.esDesactualizado = 0 THEN ps.codBarra END) AS cantidad_productos_actualizados,
            SUM(CASE WHEN ps.esDesactualizado = 0 THEN ps.precio ELSE 0 END) AS total_precios
        FROM
            ProductosCompletos ps
        GROUP BY
            ps.nomSupermercado
    ),
    -- CTE para determinar el supermercado ganador (solo considera productos actualizados)
    SupermercadoGanador AS (
        SELECT TOP 1
            nomSupermercado
        FROM
            ConteoProductos
        WHERE
            cantidad_productos_actualizados = (SELECT COUNT(DISTINCT cod_barra) FROM @Barras)
        ORDER BY
            total_precios ASC
    )
    -- Resultado final
    SELECT 
        pc.codBarra,
        pc.nomProducto,
        pc.imagen,
        pc.nomSupermercado,
        pc.precio,
        cp.total_precios AS totalXSupermercado,
        CASE
            WHEN pc.esDesactualizado = 1 THEN 'Producto no actualizado hoy'
            WHEN pc.precio = MIN(pc.precio) OVER (PARTITION BY pc.codBarra) THEN 'Mejor precio'
            ELSE 'Precio regular'
        END AS estadoPrecio,
        CASE
            WHEN pc.esDesactualizado = 1 THEN 0
            WHEN pc.nomSupermercado = (SELECT nomSupermercado FROM SupermercadoGanador) THEN 1
            ELSE 0
        END AS superGanador,
        pc.esDesactualizado
    FROM 
        ProductosCompletos pc
    JOIN
        ConteoProductos cp ON pc.nomSupermercado = cp.nomSupermercado
    ORDER BY 
        pc.codBarra, pc.esDesactualizado, pc.precio;
END;
GO

--execute buscar_productos @filtro= 'pan'
--execute buscar_productos @filtro = 'Pan', @filtro_categorias = '1', @filtro_marca = '3', @filtro_tipo = '5'
--execute buscar_productos @filtro = null, @filtro_categorias = null, @filtro_marca = null, @filtro_tipo = '5'

CREATE OR ALTER PROCEDURE buscar_productos(@filtro VARCHAR(255) = NULL, @filtro_categorias VARCHAR(255) = NULL, @filtro_marca VARCHAR(255) = NULL, @filtro_tipo VARCHAR(255) = NULL)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT p.cod_barra, p.nom_producto, p.desc_producto, mp.nom_marca, tp.nom_tipo_producto, p.imagen
    FROM productos AS p
    INNER JOIN marcas_productos AS mp ON p.nro_marca = mp.nro_marca
    INNER JOIN tipos_productos AS tp ON p.nro_tipo_producto = tp.nro_tipo_producto
    INNER JOIN categorias_productos AS cp ON p.nro_categoria = cp.nro_categoria
    INNER JOIN rubros_productos AS rp ON cp.nro_rubro = rp.nro_rubro
    WHERE (p.nom_producto LIKE '%' + ISNULL(@filtro, '') + '%'
       OR mp.nom_marca LIKE '%' + ISNULL(@filtro, '') + '%'
       OR tp.nom_tipo_producto LIKE '%' + ISNULL(@filtro, '') + '%') -- Manejo de @filtro NULL
       AND (ISNULL(@filtro_categorias, '') = '' OR cp.nro_categoria IN (SELECT value FROM STRING_SPLIT(ISNULL(@filtro_categorias,''), ','))) -- Manejo de @filtro_categorias NULL
       AND (ISNULL(@filtro_marca, '') = '' OR mp.nro_marca IN (SELECT value FROM STRING_SPLIT(ISNULL(@filtro_marca,''), ',')))  -- Manejo de @filtro_marca NULL
       AND (ISNULL(@filtro_tipo, '') = '' OR tp.nro_tipo_producto IN (SELECT value FROM STRING_SPLIT(ISNULL(@filtro_tipo,''), ','))) -- Manejo de @filtro_tipo NULL
	   AND p.vigente = 1
    UNION

    SELECT p.cod_barra, p.nom_producto, p.desc_producto, mp.nom_marca, tp.nom_tipo_producto, p.imagen
    FROM productos AS p
    INNER JOIN marcas_productos AS mp ON p.nro_marca = mp.nro_marca
    INNER JOIN tipos_productos AS tp ON p.nro_tipo_producto = tp.nro_tipo_producto
    INNER JOIN categorias_productos AS cp ON p.nro_categoria = cp.nro_categoria
    INNER JOIN rubros_productos AS rp ON cp.nro_rubro = rp.nro_rubro
    WHERE mp.nom_marca LIKE '%' + ISNULL(@filtro, '') + '%'  -- Manejo de @filtro NULL en la segunda parte del UNION
       AND (ISNULL(@filtro_categorias, '') = '' OR cp.nro_categoria IN (SELECT value FROM STRING_SPLIT(ISNULL(@filtro_categorias,''), ',')))-- Manejo de @filtro_categorias NULL
       AND (ISNULL(@filtro_marca, '') = '' OR mp.nro_marca IN (SELECT value FROM STRING_SPLIT(ISNULL(@filtro_marca,''), ','))) -- Manejo de @filtro_marca NULL
       AND (ISNULL(@filtro_tipo, '') = '' OR tp.nro_tipo_producto IN (SELECT value FROM STRING_SPLIT(ISNULL(@filtro_tipo,''), ','))) -- Manejo de @filtro_tipo NULL
	   AND p.vigente = 1
END;
GO


----------------------------------------------------------------------------------------------------
-- Seccion Servicios
----------------------------------------------------------------------------------------------------

create or alter procedure dbo.get_servicios
as
begin

  select 
		nroSupermercado = ss.nro_supermercado,
        urlServicio = ss.url_servicio,
        tipoServicio = ss.tipo_servicio,
        tokenServicio = ss.token_servicio,
        fechaUltActServicio = ss.fecha_ult_act_servicio,
		nameSpaceSoap = iss.namespace_soap,
		serviceNameSoap = iss.servicename_soap,
		portNameSoap = iss.portname_soap
    from servicios_supermercados ss (nolock)
	left join servicios_soap_supermercados iss on ss.nro_supermercado = iss.nro_supermercado
end
go

----------------------------------------------------------------------------------------------------
-- Seccion Batch
----------------------------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE dbo.sp_abm_sucursales
    @json_sucursales NVARCHAR(MAX),
    @nro_supermercado INTEGER
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Variables para el control de errores
    DECLARE @error_message NVARCHAR(MAX);
    DECLARE @error_number INTEGER;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Tabla temporal para sucursales del JSON
        CREATE TABLE #SucursalesTemp (
            nomSucursal VARCHAR(255) NOT NULL,
            calle VARCHAR(255),
            nroCalle INTEGER,
            telefonos VARCHAR(50),
            coordLatitud VARCHAR(255),
            coordLongitud VARCHAR(255),
            nroLocalidad INTEGER NOT NULL,
            horarioSucursal VARCHAR(255),
            serviciosDisponibles VARCHAR(255),
            PRIMARY KEY (nomSucursal) -- Aseguramos nombres únicos
        );

        -- Insertar datos del JSON
        INSERT INTO #SucursalesTemp (
            nomSucursal, calle, nroCalle, telefonos, 
            coordLatitud, coordLongitud, nroLocalidad, 
            horarioSucursal, serviciosDisponibles
        )
        SELECT 
            nomSucursal, calle, nroCalle, telefonos,
            coordLatitud, coordLongitud, nroLocalidad,
            horarioSucursal, serviciosDisponibles
        FROM OPENJSON(@json_sucursales)
        WITH (
            nomSucursal VARCHAR(255) '$.nomSucursal',
            calle VARCHAR(255) '$.calle',
            nroCalle INTEGER '$.nroCalle',
            telefonos VARCHAR(50) '$.telefonos',
            coordLatitud VARCHAR(255) '$.coordLatitud',
            coordLongitud VARCHAR(255) '$.coordLongitud',
            nroLocalidad INTEGER '$.nroLocalidad',
            horarioSucursal VARCHAR(255) '$.horarioSucursal',
            serviciosDisponibles VARCHAR(255) '$.serviciosDisponibles'
        );

        -- 1. Deshabilitar todas las sucursales de este supermercado que no están en el JSON
        UPDATE s
        SET habilitada = 0
        FROM dbo.sucursales s
        WHERE s.nro_supermercado = @nro_supermercado
          AND s.habilitada = 1
          AND NOT EXISTS (
              SELECT 1 FROM #SucursalesTemp t 
              WHERE t.nomSucursal = s.nom_sucursal
          );

        -- 2. Actualizar las sucursales existentes que están en el JSON
        UPDATE s
        SET 
            s.calle = t.calle,
            s.nro_calle = t.nroCalle,
            s.telefonos = t.telefonos,
            s.coord_latitud = t.coordLatitud,
            s.coord_longitud = t.coordLongitud,
            s.nro_localidad = t.nroLocalidad,
            s.horario_sucursal = t.horarioSucursal,
            s.servicios_disponibles = t.serviciosDisponibles,
            s.habilitada = 1 -- Siempre habilitar si está en el JSON
        FROM dbo.sucursales s
        INNER JOIN #SucursalesTemp t ON s.nom_sucursal = t.nomSucursal
        WHERE s.nro_supermercado = @nro_supermercado;

        -- 3. Insertar nuevas sucursales que no existen
        INSERT INTO dbo.sucursales (
            nro_supermercado, 
            nom_sucursal, 
            calle, 
            nro_calle, 
            telefonos, 
            coord_latitud, 
            coord_longitud, 
            nro_localidad, 
            horario_sucursal, 
            servicios_disponibles,
            habilitada
        )
        SELECT 
            @nro_supermercado, 
            t.nomSucursal, 
            t.calle, 
            t.nroCalle, 
            t.telefonos, 
            t.coordLatitud, 
            t.coordLongitud, 
            t.nroLocalidad, 
            t.horarioSucursal, 
            t.serviciosDisponibles,
            1 -- Nuevas sucursales siempre habilitadas
        FROM #SucursalesTemp t
        WHERE NOT EXISTS (
            SELECT 1 FROM dbo.sucursales s 
            WHERE s.nro_supermercado = @nro_supermercado 
              AND s.nom_sucursal = t.nomSucursal
        );

        -- Eliminar tabla temporal
        DROP TABLE #SucursalesTemp;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Capturar errores
        SELECT @error_message = ERROR_MESSAGE(), @error_number = ERROR_NUMBER();

        -- Revertir la transacción si ocurre un error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Eliminar tabla temporal en caso de error
        IF OBJECT_ID('tempdb..#SucursalesTemp') IS NOT NULL
            DROP TABLE #SucursalesTemp;

        -- Lanzar una excepción con información del error
        THROW;
        RETURN -1; -- Indicar fallo
    END CATCH;

    RETURN 0; -- Indicar éxito
END;
GO


CREATE OR ALTER PROCEDURE dbo.sp_abm_productos_sucursales
    @json_productos NVARCHAR(MAX),
    @nro_supermercado INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Declarar tabla temporal con estructura mejorada
        CREATE TABLE #ProductosTemp (
            codBarra VARCHAR(13),
            nomProducto VARCHAR(255),
            descProducto VARCHAR(500),
            nroCategoria INT,
            imagen VARCHAR(255),
            nomMarca VARCHAR(255),
            nomTipoProducto VARCHAR(255),
            nomSucursal VARCHAR(255),
            precio DECIMAL(18,2) NULL
        );

        -- Insertar datos del JSON con manejo de precio opcional
        INSERT INTO #ProductosTemp
        SELECT 
            codBarra,
            nomProducto,
            descProducto,
            nroCategoria,
            imagen,
            nomMarca,
            nomTipoProducto,
            nomSucursal,
            precio
        FROM OPENJSON(@json_productos)
        WITH (
            codBarra VARCHAR(13) '$.codBarra',
            nomProducto VARCHAR(255) '$.nomProducto',
            descProducto VARCHAR(500) '$.descProducto',
            nroCategoria INT '$.nroCategoria',
            imagen VARCHAR(255) '$.imagen',
            nomMarca VARCHAR(255) '$.nomMarca',
            nomTipoProducto VARCHAR(255) '$.nomTipoProducto',
            nomSucursal VARCHAR(255) '$.nomSucursal',
            precio DECIMAL(18,2) '$.precio'
        );

        -- Crear tablas temporales para evitar duplicados en MERGE
        CREATE TABLE #MarcasTemp (
            nomMarca VARCHAR(255) PRIMARY KEY
        );
        
        CREATE TABLE #TiposTemp (
            nomTipoProducto VARCHAR(255) PRIMARY KEY
        );
        
        CREATE TABLE #ProductosDistinct (
            codBarra VARCHAR(13) PRIMARY KEY,
            nomProducto VARCHAR(255),
            descProducto VARCHAR(500),
            nroCategoria INT,
            imagen VARCHAR(255),
            nomMarca VARCHAR(255),
            nomTipoProducto VARCHAR(255)
        );

        -- Insertar datos únicos en las tablas temporales
        INSERT INTO #MarcasTemp
        SELECT DISTINCT nomMarca 
        FROM #ProductosTemp 
        WHERE nomMarca IS NOT NULL;
        
        INSERT INTO #TiposTemp
        SELECT DISTINCT nomTipoProducto 
        FROM #ProductosTemp 
        WHERE nomTipoProducto IS NOT NULL;
        
        INSERT INTO #ProductosDistinct
        SELECT 
            codBarra,
            MAX(nomProducto) AS nomProducto,
            MAX(descProducto) AS descProducto,
            MAX(nroCategoria) AS nroCategoria,
            MAX(imagen) AS imagen,
            MAX(nomMarca) AS nomMarca,
            MAX(nomTipoProducto) AS nomTipoProducto
        FROM #ProductosTemp
        GROUP BY codBarra;

        -- MERGE para marcas_productos (usando tabla temporal con claves únicas)
        MERGE INTO marcas_productos AS Target
        USING #MarcasTemp AS Source
        ON Target.nom_marca = Source.nomMarca
        WHEN NOT MATCHED THEN 
            INSERT (nom_marca, vigente) 
            VALUES (Source.nomMarca, 1);

        -- MERGE para tipos_productos (usando tabla temporal con claves únicas)
        MERGE INTO tipos_productos AS Target
        USING #TiposTemp AS Source
        ON Target.nom_tipo_producto = Source.nomTipoProducto
        WHEN NOT MATCHED THEN 
            INSERT (nom_tipo_producto) 
            VALUES (Source.nomTipoProducto);

        -- MERGE para tipos_productos_marcas (usando estructura de INDEC)
        MERGE INTO tipos_productos_marcas AS Target
        USING (
            SELECT DISTINCT 
                mp.nro_marca, 
                tp.nro_tipo_producto
            FROM #ProductosTemp pt
            JOIN marcas_productos mp ON pt.nomMarca = mp.nom_marca
            JOIN tipos_productos tp ON pt.nomTipoProducto = tp.nom_tipo_producto
            WHERE pt.nomMarca IS NOT NULL AND pt.nomTipoProducto IS NOT NULL
        ) AS Source
        ON Target.nro_marca = Source.nro_marca AND Target.nro_tipo_producto = Source.nro_tipo_producto
        WHEN NOT MATCHED THEN 
            INSERT (nro_marca, nro_tipo_producto, vigente) 
            VALUES (Source.nro_marca, Source.nro_tipo_producto, 1);

        -- MERGE para productos (usando datos únicos por código de barras)
        MERGE INTO productos AS Target
        USING (
            SELECT 
                pt.codBarra, 
                pt.nomProducto, 
                pt.descProducto, 
                pt.nroCategoria, 
                pt.imagen, 
                mp.nro_marca, 
                tp.nro_tipo_producto
            FROM #ProductosDistinct pt
            LEFT JOIN marcas_productos mp ON pt.nomMarca = mp.nom_marca
            LEFT JOIN tipos_productos tp ON pt.nomTipoProducto = tp.nom_tipo_producto
        ) AS Source
        ON Target.cod_barra = Source.codBarra
        WHEN MATCHED THEN
            UPDATE SET 
                Target.nom_producto = ISNULL(Source.nomProducto, Target.nom_producto),
                Target.desc_producto = ISNULL(Source.descProducto, Target.desc_producto),
                Target.nro_categoria = ISNULL(Source.nroCategoria, Target.nro_categoria),
                Target.imagen = ISNULL(Source.imagen, Target.imagen),
                Target.nro_marca = ISNULL(Source.nro_marca, Target.nro_marca),
                Target.nro_tipo_producto = ISNULL(Source.nro_tipo_producto, Target.nro_tipo_producto),
                Target.vigente = 1
        WHEN NOT MATCHED THEN
            INSERT (cod_barra, nom_producto, desc_producto, nro_categoria, imagen, nro_marca, nro_tipo_producto, vigente)
            VALUES (Source.codBarra, Source.nomProducto, Source.descProducto, Source.nroCategoria, Source.imagen, 
                   Source.nro_marca, Source.nro_tipo_producto, 1);

        -- Actualizar productos_supermercados para productos que están en el JSON
        MERGE INTO productos_supermercados AS Target
        USING (
            SELECT 
                @nro_supermercado AS nro_supermercado,
                s.nro_sucursal AS nro_sucursal,
                pt.codBarra,
                pt.precio,
                GETDATE() AS fecha_ult_actualizacion
            FROM #ProductosTemp pt
            JOIN sucursales s ON pt.nomSucursal = s.nom_sucursal
            WHERE s.nro_supermercado = @nro_supermercado
        ) AS Source
        ON Target.nro_supermercado = Source.nro_supermercado 
           AND Target.nro_sucursal = Source.nro_sucursal 
           AND Target.cod_barra = Source.codBarra
        WHEN MATCHED THEN
            UPDATE SET 
                Target.precio = ISNULL(Source.precio, Target.precio),
                Target.fecha_ult_actualizacion = Source.fecha_ult_actualizacion
        WHEN NOT MATCHED THEN
            INSERT (nro_supermercado, nro_sucursal, cod_barra, precio, fecha_ult_actualizacion)
            VALUES (Source.nro_supermercado, Source.nro_sucursal, Source.codBarra, Source.precio, Source.fecha_ult_actualizacion);

        -- 1. Primero actualizar todos los productos del supermercado a vigente=0
        UPDATE p
        SET vigente = 0
        FROM productos p
        INNER JOIN productos_supermercados ps ON p.cod_barra = ps.cod_barra
        WHERE ps.nro_supermercado = @nro_supermercado;
        
        -- 2. Luego actualizar a vigente=1 solo los productos que están en el JSON
        UPDATE p
        SET vigente = 1
        FROM productos p
        INNER JOIN #ProductosTemp pt ON p.cod_barra = pt.codBarra
        INNER JOIN productos_supermercados ps ON p.cod_barra = ps.cod_barra
        WHERE ps.nro_supermercado = @nro_supermercado;

        -- Eliminar tablas temporales
        DROP TABLE #ProductosTemp;
        DROP TABLE #MarcasTemp;
        DROP TABLE #TiposTemp;
        DROP TABLE #ProductosDistinct;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        -- Eliminar tablas temporales en caso de error
        IF OBJECT_ID('tempdb..#ProductosTemp') IS NOT NULL DROP TABLE #ProductosTemp;
        IF OBJECT_ID('tempdb..#MarcasTemp') IS NOT NULL DROP TABLE #MarcasTemp;
        IF OBJECT_ID('tempdb..#TiposTemp') IS NOT NULL DROP TABLE #TiposTemp;
        IF OBJECT_ID('tempdb..#ProductosDistinct') IS NOT NULL DROP TABLE #ProductosDistinct;
            
        THROW;
    END CATCH;
END;
GO


CREATE OR ALTER PROCEDURE sp_abm_precios 
    @json_precios NVARCHAR(MAX),
    @nro_supermercado INT
AS
BEGIN
    -- Declarar tabla temporal para almacenar los datos del JSON
    CREATE TABLE #PreciosTemp (
        nomSucursal VARCHAR(255),
        codBarra VARCHAR(13),
        precio DECIMAL(10, 2)
    );

    -- Insertar datos del JSON a la tabla temporal
    INSERT INTO #PreciosTemp (nomSucursal, codBarra, precio)
    SELECT nomSucursal, codBarra, precio
    FROM OPENJSON(@json_precios)
    WITH (
        nomSucursal VARCHAR(255) '$.nomSucursal',
        codBarra VARCHAR(13) '$.codBarra',
        precio DECIMAL(10, 2) '$.precio'
    );

    -- Actualizar la tabla productos_supermercados
    UPDATE ps
    SET ps.precio = pt.precio,
        ps.fecha_ult_actualizacion = GETDATE()
    FROM dbo.productos_supermercados ps
    INNER JOIN #PreciosTemp pt ON ps.cod_barra = pt.codBarra
    INNER JOIN dbo.sucursales s ON ps.nro_supermercado = s.nro_supermercado AND ps.nro_sucursal = s.nro_sucursal
    INNER JOIN dbo.productos p on p.cod_barra = ps.cod_barra
    WHERE ps.nro_supermercado = @nro_supermercado AND s.nom_sucursal = pt.nomSucursal
    --  AND ps.precio IS NULL; -- Solo actualiza si el precio es NULL
    AND p.vigente = 1

    -- Manejo de errores (opcional, pero recomendado)
    IF @@ROWCOUNT = 0
    BEGIN
        -- No se actualizaron filas, posiblemente por datos incorrectos en el JSON o en las tablas relacionadas.
        -- Puedes agregar lógica para manejar este caso, como lanzar un error o registrar un mensaje.
        -- Ejemplo:
        -- RAISERROR('No se encontraron registros para actualizar.', 16, 1)
        PRINT 'No se encontraron registros para actualizar o los precios ya estaban cargados.'
    END;

    -- Eliminar la tabla temporal
    DROP TABLE #PreciosTemp;
END;
GO
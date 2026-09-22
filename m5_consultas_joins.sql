USE Ventas_Tech_DB;

-- ==============================================================================
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Combina ventas con clientes, productos y categorías en una sola consulta.
-- ==============================================================================
SELECT 
    v.fecha_venta AS fecha,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS region,
    p.nombre_producto AS descripcion_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;


-- ==============================================================================
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Identifica los clientes registrados que aún no han realizado compras.
-- ==============================================================================
SELECT 
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ==============================================================================
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Identifica los productos del catálogo que no tienen movimiento de ventas.
-- ==============================================================================
SELECT 
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;


-- ==============================================================================
-- Consulta 4: Consolidado por canal (UNION ALL + GROUP BY)
-- Clasifica las ventas por origen (Online vs Presencial) y consolida los totales.
-- ==============================================================================
SELECT 
    canal,
    SUM(total) AS total_venta,
    COUNT(*) AS cantidad_transacciones
FROM (
    SELECT 
        fecha_venta AS fecha, 
        (cantidad * precio_unitario) AS total, 
        'Online' AS canal
    FROM ventas 
    WHERE id_venta % 2 <> 0

    UNION ALL

    SELECT 
        fecha_venta AS fecha, 
        (cantidad * precio_unitario) AS total, 
        'Presencial' AS canal
    FROM ventas 
    WHERE id_venta % 2 = 0
) AS ventas_por_canal
GROUP BY canal;
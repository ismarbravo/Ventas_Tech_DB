USE ventas_tech_db;

-- 1. Ticket promedio (Media)
SELECT 
    ROUND(AVG(cantidad * precio_unitario), 2) AS ticket_promedio_media
FROM ventas;

-- 2. Resumen Estadístico: Media vs Mediana y Límites IQR
SELECT 
    644.40 AS media,
    385.00 AS mediana,
    228.00 AS q1,
    787.50 AS q3,
    (787.50 - 228.00) AS iqr,
    ROUND(228.00 - 1.5 * (787.50 - 228.00), 2) AS limite_inferior,
    ROUND(787.50 + 1.5 * (787.50 - 228.00), 2) AS limite_superior;

-- 3. Identificación del Outlier superior (> $1626.75)
SELECT 
    v.id_venta,
    c.nombre AS cliente,
    p.nombre_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN productos p ON v.id_producto = p.id_producto
WHERE (v.cantidad * v.precio_unitario) > 1626.75;

CREATE DATABASE IF NOT EXISTS kaggle_superstore;
USE kaggle_superstore;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    customer_id VARCHAR(20) PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    segmento VARCHAR(50)
);

CREATE TABLE ventas (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    fecha_compra DATE NOT NULL,
    total_venta DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES clientes(customer_id)
);

INSERT INTO clientes (customer_id, nombre_cliente, segmento) VALUES
('CG-12520', 'Claire Gute', 'Consumer'),
('DV-13045', 'Darrin Van Huff', 'Corporate'),
('SO-20335', 'Sean ODonnell', 'Consumer'),
('BH-11710', 'Brosina Hoffman', 'Consumer'),
('AA-10480', 'Andrew Allen', 'Consumer'),
('IM-15070', 'Irene Maddox', 'Corporate'),
('HP-14815', 'Harold Pawlan', 'Home Office'),
('PK-19075', 'Pete Kriz', 'Consumer');

INSERT INTO ventas (order_id, customer_id, fecha_compra, total_venta) VALUES
('CA-2024-1001', 'CG-12520', '2024-12-30', 731.94),
('CA-2024-1002', 'DV-13045', '2024-12-28', 14.62),
('CA-2024-1003', 'SO-20335', '2024-12-22', 957.58),
('CA-2024-1004', 'BH-11710', '2024-12-15', 48.86),
('CA-2024-1005', 'AA-10480', '2024-12-08', 1706.18),
('CA-2024-1006', 'IM-15070', '2024-12-02', 25.55),
('CA-2024-0995', 'HP-14815', '2024-11-18', 22.36),
('CA-2024-0980', 'PK-19075', '2024-10-15', 307.92);

-- Consulta requerida: Ventas de los últimos 30 días
SELECT 
    c.nombre_cliente,
    v.fecha_compra,
    v.total_venta
FROM ventas v
INNER JOIN clientes c ON v.customer_id = c.customer_id
WHERE v.fecha_compra >= (
    SELECT DATE_SUB(MAX(fecha_compra), INTERVAL 30 DAY) 
    FROM ventas
)
ORDER BY v.fecha_compra DESC;

USE kaggle_superstore;

DROP TABLE IF EXISTS ventas_semana;

CREATE TABLE ventas_semana (
    sucursal VARCHAR(20),
    venta DECIMAL(10, 2)
);

INSERT INTO ventas_semana (sucursal, venta) VALUES
('Norte', 500),
('Norte', 510),
('Norte', 490),
('Norte', 505),
('Norte', 495),
('Sur', 100),
('Sur', 900),
('Sur', 50),
('Sur', 1200),
('Sur', 250);

-- Métricas: Media, Rango y Desvío Estándar Muestral
SELECT 
    sucursal,
    AVG(venta) AS media,
    MAX(venta) - MIN(venta) AS rango,
    STDDEV_SAMP(venta) AS desvio_muestral
FROM ventas_semana
GROUP BY sucursal;

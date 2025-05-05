-- ===================================================================
-- Objetivo: Por cada id, quedarnos solo con la fila de last_edited más reciente
-- Entrada  : ciudades_homogenizadas
-- Salida   : sin_duplicados
-- Fecha    : 05-05-2025
-- ===================================================================

CREATE OR REPLACE VIEW
  `complete-verve-362421.datos_mercado_inmobiliario.sin_duplicados` AS

WITH ordered AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY id
      ORDER BY last_edited DESC
    ) AS rn
  FROM
    `complete-verve-362421.datos_mercado_inmobiliario.ciudades_homogenizadas`
)

SELECT
  * EXCEPT(rn)
FROM
  ordered
WHERE
  rn = 1;

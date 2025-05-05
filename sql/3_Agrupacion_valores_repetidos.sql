-- 1. Identificar qué IDs están duplicados en la etapa de ciudades estandarizadas
WITH duplicate_ids AS (
  SELECT
    id,
    COUNT(*) AS cnt
  FROM
    `complete-verve-362421.datos_mercado_inmobiliario.ciudades_homogenizadas`
  GROUP BY
    id
  HAVING
    COUNT(*) > 1
)

-- 2. Listar todos los registros duplicados con sus distintas fechas
SELECT
  t.id,
  t.last_edited,
  t.fecha_insercion_interna,
  t.fecha_publicacion,
  t.fecha_insercion_third_party
FROM
  `complete-verve-362421.datos_mercado_inmobiliario.ciudades_homogenizadas` AS t
JOIN
  duplicate_ids AS d
  ON t.id = d.id
ORDER BY
  t.id,
  t.last_edited DESC;

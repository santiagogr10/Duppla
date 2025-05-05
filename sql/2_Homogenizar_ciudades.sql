-- Archivo: sql/homogenizar_ciudades.sql
-- Objetivo: Homogeneizar la columna ciudad sobre los datos raw
-- Entrada : complete-verve-362421.datos_mercado_inmobiliario.data_cruda
-- Salida  : stg_clean_01_cities
-- ========================================================================

CREATE OR REPLACE VIEW
  `complete-verve-362421.datos_mercado_inmobiliario.ciudades_homogenizadas` AS

WITH base AS (
  SELECT
    *,
    ---------------------------------------------------------------------
    -- 1) clave uniforme, solo minúsculas sin tildes y sin caracteres raros (quitando puntos y espacios)
    ---------------------------------------------------------------------
    REGEXP_REPLACE(
      TRANSLATE(LOWER(ciudad),
                'áéíóúÁÉÍÓÚ',
                'aeiouAEIOU'),
      r'[^a-z0-9]',
      ''
    ) AS ciudad_key
  FROM
    `complete-verve-362421.datos_mercado_inmobiliario.data_cruda`
)

SELECT
  base.* REPLACE (
    ---------------------------------------------------------------------
    -- 2) mapeo: cualquiera de estas llaves → "Bogota DC"
    ---------------------------------------------------------------------
    CASE
      WHEN ciudad_key IN (
            'bogota',     -- “bogota”
            'bogotadc',   -- “bogota d.c.”, “bogota dc.”, “bogota dc”
            'bogota'      -- “bogotá” sin tilde
      )
        THEN 'Bogota DC'
      ELSE ciudad          -- si apareciese algo inesperado, lo deja igual
    END AS ciudad
  )
FROM base;

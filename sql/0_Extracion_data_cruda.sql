-- ===========================================================================
-- Archivo: extraccion_data_cruda.sql
-- Objetivo: Extraer toda la tabla cruda a una vista de staging (raw data)
-- Entrada : dataset_prueba_data
-- Salida  : stg_raw_data
-- ===========================================================================
CREATE OR REPLACE VIEW
  `complete-verve-362421.datos_mercado_inmobiliario.data_cruda` AS
SELECT
  *
FROM
  `complete-verve-362421.datos_mercado_inmobiliario.dataset_prueba_data`;

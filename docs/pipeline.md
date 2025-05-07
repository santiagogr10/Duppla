# 📌 Pipeline del Proyecto de Análisis Inmobiliario (Duppla)

Este documento describe detalladamente el flujo o *pipeline* implementado en este proyecto para el análisis integral del mercado inmobiliario en Bogotá. Aquí se explican todos los pasos desde la limpieza inicial, detección y manejo de valores atípicos hasta el modelo final de análisis estadístico.

---

## 🔄 Etapas del Pipeline

El pipeline está dividido en tres grandes etapas:

1. **Limpieza y eliminación de duplicados**
2. **Detección y manejo de valores atípicos**
3. **Modelado estadístico y generación de insights**

---

## 1️⃣ Limpieza y Eliminación de Duplicados

Esta primera etapa busca garantizar la calidad de los datos mediante la eliminación de registros duplicados.

### 📌 Pasos realizados:

#### ✅ **Filtro 1: Duplicados por ID**

* **Criterio**: Se eliminaron registros que compartían el mismo `id`, ya que representan duplicados exactos.

#### ✅ **Filtro 2: Duplicados estrictos por múltiples categorías**

* **Criterio**: Se eliminaron filas duplicadas que coincidían exactamente en las siguientes columnas ( se quedaba con el dato que tenia la fecha de edición mas reciente ):

  ```yaml
  portal_inmobiliario, codigo_web, tipo_inmueble, latitud, longitud, area
  ```
* **Justificación**: Considerados duplicados inequívocos (filtro fuerte).

#### ✅ **Filtro 3: Duplicados por similitud de texto (fuzzy matching - 99%)**

* **Criterio**: Duplicados en función del `codigo_web`, `tipo_inmueble` y descripciones textuales con similitud ≥ 99%.
* **Herramienta usada**: RapidFuzz para fuzzy matching de texto.
* **Objetivo**: Identificar y remover duplicados en inmuebles con pequeñas variaciones descriptivas.

#### ✅ **Filtro 4: Duplicados cruzados entre portales inmobiliarios**

* **Criterio**: Duplicados entre portales diferentes que coinciden en:

  ```yaml
  latitud, longitud, area, tipo_inmueble, habitaciones, banios, precio
  ```

  con descripciones textuales ≥ 96% de similitud.
* **Justificación**: Identificación de inmuebles duplicados anunciados en múltiples plataformas.

---

## 2️⃣ Detección y Manejo de Valores Atípicos (Outliers)

Esta segunda etapa consistió en detectar y eliminar valores atípicos que distorsionan el análisis.

### 📌 Variables analizadas:

* **Área del inmueble** (`area`)
* **Precio del inmueble** (`precio_venta`)
* **Número de habitaciones** (`habitaciones`)
* **Número de baños** (`banios`)
* **Número de parqueaderos** (`parqueaderos`)
* **Número de piso** (`piso`)

### 📌 Métodos utilizados:

* **Área y Precio** ( Se detectaron se analizaron y eiminaron ) :

  * Se utilizaron rangos intercuartílicos (IQR), eliminando:

    * Inmuebles con área menor a 20 m² o superior al límite superior definido por el método IQR.
    * Precios menores a 110 millones o superiores al límite superior definido por el método IQR.

* **Habitaciones, baños, parqueaderos y piso** ( Se detectaron y analizaron):

  * Se establecieron umbrales realistas basados en la distribución de datos y conocimiento del mercado:

    * Baños: máximo 10 unidades.
    * Habitaciones: máximo 12 unidades.
    * Parqueaderos: máximo 10 unidades.
    * Piso: máximo piso considerado relevante fue 30, agrupando pisos superiores a este en una categoría "30+".

---

## 3️⃣ Modelado Estadístico y Generación de Insights

Esta etapa se centró en la generación de clusters (segmentación) y la aplicación de regresión polinómica para analizar la relación entre el valor del metro cuadrado y el número de piso en que está ubicado cada apartamento.

### 📌 Segmentación (Clustering):

* **Algoritmo utilizado**: MiniBatchKMeans (Scikit-learn).
* **Características seleccionadas**:

  * Geográficas (`latitud`, `longitud`).
* **Objetivo**: Crear grupos homogéneos por ubicación geográfica para luego modelar comportamientos específicos dentro de estos grupos.

### 📌 Regresión polinómica por cluster:

* **Tipo de regresión**: Regresión polinómica (grado 2).
* **Variable dependiente (y)**: Valor del metro cuadrado (`precio_m2`).
* **Variable independiente (x)**: Número de piso del inmueble (`piso`).
* **Metodología**:

  * Para cada cluster se realizó una regresión sobre el promedio del valor del metro cuadrado por cada piso.
  * Se determinó la pendiente promedio (derivada del polinomio) que indica el incremento esperado del valor por piso.
* **Resultado**:

  * Promedio del incremento del precio por metro cuadrado al subir de piso dentro de cada cluster.
  * Este método permite entender mejor cómo el piso influye en el precio dentro de segmentos geográficos específicos.

---


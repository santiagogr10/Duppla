
# 📊 Proyecto Análisis del Mercado Inmobiliario de Bogotá (Duppla challenge)

## 🔍 Descripción del Proyecto
Este proyecto comprende un análisis detallado del mercado inmobiliario de apartamentos en Bogotá. El objetivo principal es identificar, limpiar, procesar y analizar datos provenientes de múltiples fuentes.

### 🛠️ Objetivos específicos:
- Limpieza y eliminación de duplicados.
- Identificación y tratamiento de valores atípicos.
- Análisis exploratorio y segmentación de inmuebles mediante clustering.
- Modelado estadístico para entender la relación entre valor del inmueble y el piso del 
  apartamento.

---

## 📂 Estructura del Repositorio

```


├── notebooks/
│   └── analysis.ipynb         # Notebook principal con análisis completo.
│
├── sql                        # Las querys que se utilizaron para extraer y transformar la data 
│                                en Bigquery, enumeradas para su correcta ejecución.
│
├── docs
│    └── pipeline.md           # Docuemnto que explica con mejor detalle el pipe line del análisis
│
├── .gitignore             
├── README.md                  
└── requirements.txt           # Dependencias necesarias del proyecto.

````

---

## ⚙️ Requisitos del Entorno

### Software requerido:
- Python >= 3.8
- pip

### Librerías principales:
- pandas
- numpy
- scikit-learn
- scipy
- matplotlib
- seaborn
- statsmodels

Todas las dependencias están listadas en `requirements.txt`.

---

## 🚀 Instalación y Configuración del Entorno

### 1. Clonar el repositorio:
```bash
git clone https://github.com/usuario/repo-inmobiliario.git
cd repo-inmobiliario
````

### 2. Crear entorno virtual (opcional pero recomendado):

```bash
python -m venv venv
# Activación en Windows
venv\Scripts\activate
# Activación en Linux/Mac
source venv/bin/activate
```

### 3. Instalar dependencias:

```bash
pip install -r requirements.txt
```

---

## 📑 Ejecución del Jupyter Notebook

1. Actualizar la ruta del dataset:
Antes de ejecutar las celdas, asegúrate de cambiar la ruta del archivo en la variable file_path para que apunte a la ubicación correcta del dataset en tu máquina.

2. Ejecutar las celdas en orden:
Ejecuta todas las celdas de manera secuencial para garantizar que el análisis se reproduzca correctamente.

3. Revisar resultados en puntos clave:

- Apartado "Filtro débil - posibles duplicados":
Evalúa los datos identificados como posibles duplicados. Decide si deseas eliminarlos o conservarlos según los criterios de tu análisis.

- Apartado "Valores atípicos":
Revisa los rangos establecidos para detectar valores atípicos. Si es necesario, ajusta los umbrales para adaptarlos a tus necesidades específicas.

---

## 🗃️ Detalle del Análisis Realizado

### 1. Limpieza de datos:

* **Duplicados:** Eliminación mediante múltiples filtros:

  * Por ID único.
  * Por combinación de características del inmueble.
  * Coincidencias por similitud en descripción textual (fuzzy matching).
  * Detección de inmuebles publicados en diferentes portales.

* **Valores Atípicos:**

  * Análisis sobre las variables críticas: `area`, `precio_venta`, `piso`, `habitaciones`, `banios`, `parqueaderos`.
  * Criterios basados en rangos intercuartílicos y límites definidos según conocimiento del mercado.

### 2. Clustering y Análisis Exploratorio:

* Segmentación por latitud y longitud usando MiniBatchKMeans.
* Evaluación estadística de la relación entre precio por metro cuadrado y piso mediante regresión polinómica (grado 2).

---

## 📚 Documentación Complementaria

* [Documento PDF muestra de los resultados](https://docs.getdbt.com/)

---

**Última actualización:** Mayo, 2025 🚀📅

```
```

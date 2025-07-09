# TFM-resistencia-antibioticos
Análisis genómico de resistencia en Klebsiella pneumoniae

Este repositorio contiene los scripts, análisis y resultados del Trabajo de Fin de Máster (TFM) en Bioinformática, centrado en la detección de genes de resistencia a antibióticos en aislamientos de *Klebsiella pneumoniae*, a partir de datos de secuenciación disponibles públicamente.

## Descripción del proyecto

El objetivo principal de este TFM es identificar y caracterizar genes de resistencia antimicrobiana y plásmidos asociados, utilizando herramientas bioinformáticas aplicadas a datos genómicos.

Los análisis se basan en datos de un estudio de Ecuador:

- [PMID: 39367302](https://pubmed.ncbi.nlm.nih.gov/39367302/)

## Datos utilizados

Los datos genómicos analizados provienen del repositorio europeo ENA (European Nucleotide Archive), bajo el identificador de proyecto:

- **PRJNA956653** – [ver en ENA](https://www.ebi.ac.uk/ena/browser/view/PRJNA956653)

Los archivos `.fastq` se descargaron directamente desde ENA y no se incluyen en este repositorio debido a su tamaño.

## Estructura del repositorio

TFM-resistencia-antibioticos/
├── scripts/ # Scripts bash para procesamiento y análisis
├── R-scripts/ # Scripts en R para visualización de resultados
├── results/ # Tablas resumen generadas por las herramientas
├── tfm.yml # Archivo de entorno Conda con dependencias
└── README.md # Este archivo


## Herramientas utilizadas

- [`fastp`]– control de calidad
- [`SPAdes`] – ensamblado
- [`QUAST`]– evaluación del ensamblado
- [`Prokka`]– anotación
- [`ResFinder`] - detección de genes AMR
- [`AMRFinderPlus`] – detección de genes AMR
- [`PlasmidFinder`] - detección de plásmidos
- [`Kleborate`] – tipado y virulencia


## Entorno de trabajo

Este proyecto se ejecutó en un entorno `conda`. Puede replicarse con:

```bash
conda env create -f tfm.yml
conda activate tfm_env
```

## Resultados

Las tablas de resultados más relevantes se encuentran en la carpeta `results/`:
- `resumen_resfinder.tsv`
- `amrfinder_resumen.tsv`
- `resumen_plasmidos.tsv`
- `resultados_kleborate.tsv`

## Autora

**Nerea Lázaro**  
Máster en Bioinformática  
Curso 2024–2025

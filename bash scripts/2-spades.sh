#!/bin/bash

# Ruta donde están las lecturas limpias
DIR="/home/nlazarom/TFM/ecuador/0-preparacion/limpieza"

# Ruta base donde se guardarán las carpetas de salida
OUT_BASE="/home/nlazarom/TFM/ecuador/1-ensamblado"

mkdir -p "$OUT_BASE"

# Loop para cada archivo R1
for R1 in ${DIR}/*_1.clean.fastq.gz; do
  base=$(basename "$R1" "_1.clean.fastq.gz")
  R2="${DIR}/${base}_2.clean.fastq.gz"
  
  # Carpeta de salida para cada muestra
  OUT="${OUT_BASE}/${base}"
  mkdir -p "$OUT"
  
  echo "Ejecutando SPAdes para la muestra $base..."
  
  spades.py -1 "$R1" -2 "$R2" --careful -k auto --phred-offset 33 -o "$OUT"
  
  echo "Ensamblado de $base finalizado."
done


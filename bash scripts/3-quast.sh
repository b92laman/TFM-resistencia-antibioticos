#!/bin/bash

# Directorio base donde están los ensamblajes generados por SPAdes
DIR_ENSEMBLADOS="/home/nlazarom/TFM/ecuador/1-ensamblado"

# Directorio donde están las lecturas limpias
DIR_LECTURAS="/home/nlazarom/TFM/ecuador/0-preparacion/limpieza"

# Crear carpeta base para resultados de QUAST
mkdir -p "$DIR_ENSEMBLADOS/quast_resultados"

# Loop por cada carpeta de ensamblado
for carpeta in "$DIR_ENSEMBLADOS"/*; do
  if [[ -d "$carpeta" ]]; then
    muestra=$(basename "$carpeta")
    contigs="$carpeta/contigs.fasta"
    
    if [[ -f "$contigs" ]]; then
      echo "Evaluando $muestra con QUAST..."

      mkdir -p "$DIR_ENSEMBLADOS/quast_resultados/$muestra"

      quast.py \
        -o "$DIR_ENSEMBLADOS/quast_resultados/$muestra" \
        -m 0 \
        -t 2 \
        -k \
        --k-mer-size 77 \
        --circos \
        --pe1 "$DIR_LECTURAS/${muestra}_1.clean.fastq.gz" \
        --pe2 "$DIR_LECTURAS/${muestra}_2.clean.fastq.gz" \
        "$contigs"
    else
      echo "No se encontró contigs.fasta en $carpeta, saltando..."
    fi
  fi
done


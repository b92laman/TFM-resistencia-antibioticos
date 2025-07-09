#!/bin/bash

# Ruta a los ensamblajes
INPUT_DIR="/home/nlazarom/TFM/ecuador/1-ensamblado"
# Ruta de salida
OUTPUT_DIR="/home/nlazarom/TFM/ecuador/2-anotacion"
# Archivo de proteínas de referencia (extraído o descargado)
REF_PROT="/home/nlazarom/TFM/ecuador/2-anotacion/ref_prots.faa"

mkdir -p "$OUTPUT_DIR"

# Loop sobre los ensamblados
for asm in ${INPUT_DIR}/*/contigs.fasta; do
    sample=$(basename $(dirname "$asm"))
    outdir="${OUTPUT_DIR}/${sample}"

    echo "Anotando muestra $sample..."

    prokka --outdir "$outdir" \
           --prefix "$sample" \
           --cpus 4 \
           --kingdom Bacteria \
           --genus Klebsiella \
           --species pneumoniae \
           --strain "$sample" \
           --proteins "$REF_PROT" \
           "$asm"
    
    echo "Anotación de $sample finalizada."
done


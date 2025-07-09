#!/bin/bash

# === CONFIGURACIÓN ===
input_root="/home/nlazarom/TFM/ecuador/2-anotacion"         # Carpeta raíz donde están las subcarpetas por cepa
output_dir="/home/nlazarom/TFM/ecuador/3-resistencia/amrfinder"       # Carpeta de salida
organismo="Klebsiella_pneumoniae"
identidad=0.9
cobertura=0.8

mkdir -p "$output_dir"

# === RECORRER TODAS LAS SUBCARPETAS ===
find "$input_root" -type f -name "*.ffn" | while read ffn; do
    muestra=$(basename "$ffn" .ffn)                    
    echo "Analizando $muestra..."

    amrfinder \
        --organism "$organismo" \
        -n "$ffn" \
        -c "$cobertura" \
        -i "$identidad" \
        --plus \
        --log "$output_dir/${muestra}.log" \
        > "$output_dir/${muestra}_amrfinder.tsv"
done

echo "Análisis completo. Resultados guardados en '$output_dir'."

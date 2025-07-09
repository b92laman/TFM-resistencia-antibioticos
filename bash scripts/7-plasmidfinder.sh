#!/bin/bash

# Carpeta con los archivos .fna organizados en subcarpetas por cepa
INPUT_DIR="/home/nlazarom/TFM/ecuador/2-anotacion"
# Carpeta para guardar los resultados de plasmidfinder
OUTPUT_DIR="/home/nlazarom/TFM/ecuador/4-plasmidos"

mkdir -p "$OUTPUT_DIR"

# Iterar sobre todas las subcarpetas y .fna dentro
find "$INPUT_DIR" -type f -name "*.fna" | while read -r fna_file; do
    # Extraer el nombre de la cepa (nombre de la carpeta padre o nombre archivo sin extensión)
    cepa=$(basename "$(dirname "$fna_file")")
    
    # Definir output file
    out_file="${OUTPUT_DIR}/${cepa}_plasmidfinder.tsv"
    
    # Ejecutar abricate con base de datos plasmidfinder
    abricate --db plasmidfinder "$fna_file" > "$out_file"
    
    echo "Plásmidos detectados para $cepa guardados en $out_file"
done

echo "Detección de plásmidos completada para todas las cepas."


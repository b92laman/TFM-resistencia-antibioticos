#!/bin/bash

# Ruta al directorio principal donde están las subcarpetas por cepa
BASE_DIR="/home/nlazarom/TFM/ecuador/1-ensamblado"

# Archivo de salida
OUTPUT="/home/nlazarom/TFM/ecuador/7-kleborate/resultados_kleborate.tsv"

# Crear carpeta de salida si no existe
mkdir -p "$(dirname "$OUTPUT")"

# Crear archivo de salida vacío
> "$OUTPUT"

# Activar expansión recursiva de archivos (solo para Bash)
shopt -s globstar

# Crear un array con las rutas de ensamblajes válidos
assembly_list=()

# Buscar archivos .fasta, .fa o .fna dentro de subcarpetas
for file in "$BASE_DIR"/**/*.{fasta,fa,fna}; do
  if [ -f "$file" ]; then
    echo "Añadiendo: $file"
    assembly_list+=("$file")
  fi
done

# Ejecutar Kleborate con los ensamblajes encontrados
if [ ${#assembly_list[@]} -gt 0 ]; then
  kleborate -a "${assembly_list[@]}" -o "$OUTPUT"
  echo "✅ Análisis terminado. Resultados guardados en $OUTPUT"
else
  echo "❌ No se encontraron archivos de ensamblado válidos en $BASE_DIR"
fi


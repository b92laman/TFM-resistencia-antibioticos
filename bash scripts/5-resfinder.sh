#!/bin/bash

# Carpeta con subdirectorios por cepa
BASE_DIR="/home/nlazarom/TFM/ecuador/2-anotacion"

# Carpeta donde guardar los resultados
RESULT_DIR="/home/nlazarom/TFM/ecuador/3-resistencia"

# Base de datos a usar 
DB="resfinder"

# Verifica que la carpeta de resultados exista
mkdir -p "$RESULT_DIR"

# Procesar cada subcarpeta (una por cepa)
for carpeta in "$BASE_DIR"/SRR*; do
    if [ -d "$carpeta" ]; then
        # Obtener nombre de la cepa
        cepa=$(basename "$carpeta")

        # Buscar archivo .fna generado por Prokka
        fna_file=$(find "$carpeta" -type f -name "*.fna" | head -n 1)

        if [ -f "$fna_file" ]; then
            echo "Analizando resistencia en $cepa..."
            abricate --db "$DB" "$fna_file" > "$RESULT_DIR/${cepa}_${DB}.tab"
        else
            echo "No se encontró archivo .fna en $carpeta"
        fi
    fi
done

# Crear resumen de todos los resultados
echo "🧾 Generando resumen combinado..."
abricate --summary "$RESULT_DIR"/*_${DB}.tab > "$RESULT_DIR/resumen_${DB}.tsv"

echo "✅ Todo listo. Revisa: $RESULT_DIR"


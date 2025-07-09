#!/bin/bash

# Ruta de salida personalizada
RUTA_SALIDA=~/TFM/ecuador/0-preparacion/limpieza

# Bucle para procesar cada pareja de archivos _1 y _2
for r1 in *_1.fastq.gz
do
    base=$(basename "$r1" _1.fastq.gz)
    r2="${base}_2.fastq.gz"

    echo "Procesando muestra: $base"

    fastp \
        -i "$r1" \
        -I "$r2" \
        -o "$RUTA_SALIDA/${base}_1.clean.fastq.gz" \
        -O "$RUTA_SALIDA/${base}_2.clean.fastq.gz" \
        --detect_adapter_for_pe \
        --cut_front \
        --cut_tail \
        --cut_mean_quality 30 \
        -l 50 \
        -h "$RUTA_SALIDA/${base}_fastp.html" \
        -j "$RUTA_SALIDA/${base}_fastp.json"

    echo "Muestra $base limpiada"
done

echo "Limpieza completada"


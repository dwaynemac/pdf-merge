#!/bin/bash

# Este script genera una copia de LIBRO_PDF por cada página
# de AUTOGRAFOS_PDF. Las copias tienen la página de autógrafo
# insertada al inicio.
LIBRO_PDF="libro.pdf"
AUTOGRAFOS_PDF="autografos-5.pdf"
OUTPUT_PREFIX="mais_amor_5"

# Check if the required files exist
if [ ! -f "${LIBRO_PDF}" ] || [ ! -f "${AUTOGRAFOS_PDF}" ]; then
    echo "Error: ${LIBRO_PDF} or ${AUTOGRAFOS_PDF} not found in current directory"
    echo "Please make sure both files are in the same directory as this script"
    exit 1
fi

# Create a temporary directory for split files
mkdir -p autografos_split

# Split ${AUTOGRAFOS_PDF} into individual pages
echo "Splitting ${AUTOGRAFOS_PDF} into individual pages..."
pdftk "${AUTOGRAFOS_PDF}" burst output autografos_split/autografo_%d.pdf

# Create a new version of ${LIBRO_PDF} for each autografo page
echo "Creating new versions of ${LIBRO_PDF} with each autografo page..."
for i in autografos_split/autografo_*.pdf; do
    page_num=$(basename "$i" | grep -o '[0-9]\+')
    pdftk A="${LIBRO_PDF}" B="$i" cat B1 A1 A2-end output "output/${OUTPUT_PREFIX}_${page_num}.pdf"
    echo "output/${OUTPUT_PREFIX}_${page_num}.pdf"
done

# Clean up
echo "Cleaning up temporary files..."
rm -rf autografos_split
rm doc_data.txt

echo "Done! Check the current directory for the new PDF files."

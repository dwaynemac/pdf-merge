#!/bin/bash

# Define libro.pdf and autografos-4.pdf as variables
LIBRO_PDF="libro.pdf"
AUTOGRAFOS_PDF="autografos-4.pdf"
OUTPUT_PREFIX="mais_amor_4"

# Check if the required files exist
if [ ! -f "${LIBRO_PDF}" ] || [ ! -f "${AUTOGRAFOS_PDF}" ]; then
    echo "Error: libro.pdf or autografos.pdf not found in current directory"
    echo "Please make sure both files are in the same directory as this script"
    exit 1
fi

# Create a temporary directory for split files
mkdir -p autografos_split

# Split autografos.pdf into individual pages
echo "Splitting autografos.pdf into individual pages..."
pdftk ${AUTOGRAFOS_PDF} burst output autografos_split/autografo_%d.pdf

# Create a new version of libro.pdf for each autografo page
echo "Creating new versions of libro.pdf with each autografo page..."
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

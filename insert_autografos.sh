#!/bin/bash

# Check if the required files exist
if [ ! -f "libro.pdf" ] || [ ! -f "autografos.pdf" ]; then
    echo "Error: libro.pdf or autografos.pdf not found in current directory"
    echo "Please make sure both files are in the same directory as this script"
    exit 1
fi

# Create a temporary directory for split files
mkdir -p autografos_split

# Split autografos.pdf into individual pages
echo "Splitting autografos.pdf into individual pages..."
pdftk autografos.pdf burst output autografos_split/autografo_%d.pdf

# Create a new version of libro.pdf for each autografo page
echo "Creating new versions of libro.pdf with each autografo page..."
for i in autografos_split/autografo_*.pdf; do
    page_num=$(basename "$i" | grep -o '[0-9]\+')
    pdftk A=libro.pdf B="$i" cat A1 B1 A2-end output "libro_with_autografo_${page_num}.pdf"
    echo "Created libro_with_autografo_${page_num}.pdf"
done

# Clean up
echo "Cleaning up temporary files..."
rm -rf autografos_split
rm doc_data.txt

echo "Done! Check the current directory for the new PDF files."

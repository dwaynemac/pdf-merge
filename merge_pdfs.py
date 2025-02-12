from PyPDF2 import PdfReader, PdfWriter
import os

def merge_pdfs():
    # Read the source PDFs
    autografos = PdfReader("autografos.pdf")
    libro = PdfReader("libro.pdf")
    
    # Create output directory if it doesn't exist
    output_dir = "output"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    # For each page in autografos
    for page_num in range(len(autografos.pages)):
        # Create a new PDF writer
        output = PdfWriter()
        
        # Add the current page from autografos
        output.add_page(autografos.pages[page_num])

        # Add all pages from libro
        for page in libro.pages:
            output.add_page(page)
        
        # Save the output PDF
        output_filename = os.path.join(output_dir, f"merged_page_{page_num + 1}.pdf")
        with open(output_filename, "wb") as output_file:
            output.write(output_file)
        
        print(f"Created {output_filename}")

if __name__ == "__main__":
    merge_pdfs()

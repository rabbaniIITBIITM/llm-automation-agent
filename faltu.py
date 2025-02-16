import os
import subprocess
print(os.getcwd())

def format_file_with_prettier(file_path: str, prettier_version: str):
    """
    Format the contents of a specified file using a particular formatting tool, ensuring the file is updated in-place.
    
    Args:
        file_path: The path to the file to format.  
        prettier_version: The version of Prettier to use.
    """
    input_file_path = os.path.abspath(file_path)  # Ensure absolute path
    if not os.path.exists(input_file_path):
        raise FileNotFoundError(f"File not found: {input_file_path}")

    subprocess.run(["npx", f"prettier@{prettier_version}", "--write", input_file_path], check=True)

format_file_with_prettier("\data\format.md","3.4.2")


import os
import json
import re
import shutil

def evaluate_expression(match):
    # This function is called for each arithmetic expression found in the string
    return str(eval(match.group()))

def process_file(filename):
    print(f"Processing {filename}...")

    # Step 1: Make a backup of the original .json file
    backup_filename = filename.split('.json')[0] + '_old.json'
    shutil.copy(filename, backup_filename)
    print(f"Backup for {filename} created as {backup_filename}.")

    # Step 2: Read the file as plain text
    try:
        with open(filename, 'r') as file:
            file_content = file.read()
    except Exception as e:
        print(f"Error reading {filename}. Error message:", str(e))
        return

    # Step 3: Detect arithmetic expressions and evaluate them
    modified_content = re.sub(r'(\d+\s*[+-]\s*\d+)', evaluate_expression, file_content)

    # Step 4: Try to load the modified content as JSON
    try:
        json.loads(modified_content)
        print(f"Content of {filename} is now valid JSON.")
    except Exception as e:
        print(f"Content of {filename} is still not valid JSON. Error message:", str(e))
        return

    # Step 5: Save the modified content back to the file
    with open(filename, 'w') as file:
        file.write(modified_content)
    print(f"Saved changes to {filename}.")

data_files = ["cursive.json", "hearts.json", "moons.json", "petals.json", "spirals.json"]

for filename in data_files:
    if os.path.exists(filename):
        process_file(filename)
    else:
        print(f"File {filename} does not exist.")

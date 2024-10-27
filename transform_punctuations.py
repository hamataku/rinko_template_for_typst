import sys
import os

def transform_punctuations(text):
    replacements = {
        '。': '．',
        '、': '，',
    }
    for original, replacement in replacements.items():
        text = text.replace(original, replacement)
    return text

input_file = sys.argv[1]

if not input_file.endswith('.typ'):
    print("The file is not a '.typ' file. Exiting without modification.")
    sys.exit()

print('Reading file from path:', input_file)
with open(input_file, 'r', encoding='utf-8') as file:
    text = file.read()

transformed_text = transform_punctuations(text)

if text != transformed_text:
    with open(input_file, 'w', encoding='utf-8') as file:
        file.write(transformed_text)

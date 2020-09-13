import glob
import re
import os

from pathlib import Path

# string = '&& git checkout 2192bf9fd983b70a692be0541ddc3f583e327a72 \\'
#
# print(re.sub(r'(?<=^&& git checkout \b).*(?=\b)', 'Some thing.', string))


def recursive_list(path):
    for filename in glob.iglob(os.path.join(path, '**/*README.md'), recursive=True):
        print(filename)


def file_lines(full_path):
    with open(full_path) as file:
        return file.readlines()


def aplly_regex(file: list):
    # https://stackoverflow.com/a/6186981
    regex = re.compile(r'(?<=^&& git checkout \b).*(?=\b)')

    for line in file:
        result = regex.search(line)


def main():
    recursive_list('src/examples')



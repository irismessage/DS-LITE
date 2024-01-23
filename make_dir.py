#!/usr/bin/python

import json
from os import system
from pathlib import Path
from sys import argv

from _common import PATH_SOURCE
from make_completions import make_completions


def main():
    name = argv[1]
    archiveid = argv[2]
    suffix = argv[3]

    newdir = Path(name)
    newdir.mkdir(exist_ok=True)

    source_path = newdir / PATH_SOURCE
    source_dict = {"archiveid": archiveid, "suffix": suffix}
    with open(source_path, "w") as file:
        json.dump(source_dict, file, indent=4)
        file.write("\n")

    system(f"./get_metadata.sh {newdir}")
    make_completions(newdir)


if __name__ == "__main__":
    main()

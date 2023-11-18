import json
import re

REGIONS = ("United Kingdom", "Europe")
RE_LANG = re.compile(r"\((\w+,)En(,\w+)*\)")

IN_FILE = "games.txt"
OUT_FILE = "files.txt"


def list_files() -> list[str]:
    with open("metadata.json") as fp:
        metadata = json.load(fp)
    files = metadata["files"]
    files = [f["name"] for f in files]
    return files


def search(name: str, files: list[str]):
    filter_regex = re.compile(
        r"""
        {{name}}[ ]  # name
        (\((United Kingdom|Europe)\))?[ ]  # region
        (\((\w+,)En(,\w+)*\))?[ ]  # language
        (\(NDSi Enhanced\))?  # extraneous
        .zip  # suffix
        """,
        re.VERBOSE | re.IGNORECASE
    )

    results = [f for f in files if filter_regex.fullmatch(f)]
    return results


def main():
    archive_org_files = list_files()

    with open(IN_FILE) as in_file:
        games = in_file.readlines()
    games = [g.removesuffix("\n") for g in games]

    files = [*search(name, archive_org_files) for name in games]

    files = [f + "\n" for f in files]
    with open(OUT_FILE, "w") as out_file:
        out_file.writelines(files)


if __name__ == "__main__":
    main()

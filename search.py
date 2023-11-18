import json
import re

REGIONS = ("United Kingdom", "Europe")
RE_LANG = re.compile(r"\((\w+,)En(,\w+)*\)")


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

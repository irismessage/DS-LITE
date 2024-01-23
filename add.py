#!/usr/bin/python

import os
from argparse import ArgumentParser
from pathlib import Path
from sys import argv

from _common import DEFAULT_BASEDIR, PATH_GAMES
from convert import convert


def get_parser() -> ArgumentParser:
    parser = ArgumentParser()
    parser.add_argument("-b", "--basedir", default=DEFAULT_BASEDIR, type=Path)
    parser.add_argument("target", type=Path)

    return parser


def load(games_path: Path) -> set[str]:
    with open(games_path) as file:
        games = set(file.readlines())
    return games


def save(games_path: Path, old: set[str], new: set[str]):
    added = new - old
    with open(games_path, "a") as file:
        file.writelines(added)


def add(games_path: Path, target: str):
    target = target + "\n"
    games = load(games_path)
    if target in games:
        print("Already in there")
        return

    with open(games_path, "a") as file:
        file.write(target)


def call_convert(basedir: Path):
    os.system(f"./convert.py '{basedir}'")


def main():
    parser = get_parser()
    args = parser.parse_args()

    basedir = args.basedir
    workdir = Path(__file__).parent
    games_path = workdir / basedir / PATH_GAMES
    target = args.target.stem

    add(games_path, target)
    convert(basedir)


if __name__ == "__main__":
    main()

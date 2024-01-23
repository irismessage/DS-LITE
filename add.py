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
    parser.add_argument("target", nargs="+", type=Path)

    return parser


def load(games_path: Path) -> set[str]:
    with open(games_path) as file:
        games = set(file.readlines())
    return games


def save(games_path: Path, to_add: set[str]):
    with open(games_path, "a") as file:
        file.writelines(to_add)


def add(games_path: Path, targets: list[str]) -> bool:
    targets = set(t.stem + "\n" for t in targets)

    games_path.touch()
    games = load(games_path)

    already_added = games.intersection(targets)
    to_add = targets - games

    if already_added:
        print("".join(f"Already in there: {g}" for g in already_added), end="")

    if to_add:
        print("".join(f"Adding: {g}" for g in to_add), end="")
        save(games_path, to_add)
        return True
    else:
        return False


def main():
    parser = get_parser()
    args = parser.parse_args()

    basedir = args.basedir
    workdir = Path(__file__).parent
    games_path = workdir / basedir / PATH_GAMES
    targets = args.target

    if add(games_path, targets):
        convert(basedir)


if __name__ == "__main__":
    main()

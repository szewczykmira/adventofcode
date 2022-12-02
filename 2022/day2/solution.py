from typing import Dict, Literal

OP_ROCK = "A"
OP_PAPER = "B"
OP_SCISSORS = "C"


def run1():
    Y_ROCK = "X"
    Y_PAPER = "Y"
    Y_SCISSORS = "Z"

    ROUND = {
        (OP_ROCK, Y_ROCK): 3,
        (OP_PAPER, Y_ROCK): 0,
        (OP_SCISSORS, Y_ROCK): 6,
        (OP_ROCK, Y_PAPER): 6,
        (OP_PAPER, Y_PAPER): 3,
        (OP_SCISSORS, Y_PAPER): 0,
        (OP_ROCK, Y_SCISSORS): 0,
        (OP_PAPER, Y_SCISSORS): 6,
        (OP_SCISSORS, Y_SCISSORS): 3,
    }

    SCORE: Dict[Literal["X", "Y", "Z"], int] = {Y_ROCK: 1, Y_PAPER: 2, Y_SCISSORS: 3}

    def round_score(oponent: str, you: str) -> int:
        return SCORE[you] + ROUND[(oponent, you)]  # type: ignore

    with open("input.txt") as strategy:
        suma = 0
        for line in strategy.readlines():
            suma += round_score(*line.split())

    return suma


def run2():
    to_res = {"X": 0, "Y": 3, "Z": 6}
    ROUND = {
        (OP_ROCK, "X"): 3,
        (OP_ROCK, "Y"): 1,
        (OP_ROCK, "Z"): 2,
        (OP_PAPER, "X"): 1,
        (OP_PAPER, "Y"): 2,
        (OP_PAPER, "Z"): 3,
        (OP_SCISSORS, "X"): 2,
        (OP_SCISSORS, "Y"): 3,
        (OP_SCISSORS, "Z"): 1,
    }

    def round_score(oponent: str, score: str) -> int:
        return to_res[score] + ROUND[(oponent, score)]  # type: ignore

    with open("input.txt") as strategy:
        suma = 0
        for line in strategy.readlines():
            suma += round_score(*line.split())
    return suma


print(run1())
print(run2())

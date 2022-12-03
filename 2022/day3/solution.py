from typing import Set
from functools import reduce
from math import floor
from string import ascii_letters

INPUT_FILE = "input.txt"


def items_in_the_rucksack(line: str) -> Set[str]:
    length = len(line)
    half = floor(length / 2)
    first = set(line[:half])
    second = set(line[half:])
    return first.intersection(second)


def run1():
    with open(INPUT_FILE) as rucksacks:
        priority_sum = 0
        for line in rucksacks:
            for item in items_in_the_rucksack(line):
                priority_sum += ascii_letters.index(item) + 1
    print(priority_sum)


def run2():
    with open(INPUT_FILE) as rucksacks:
        priority_sum = 0
        try:
            while True:
                three_lines = [set(next(rucksacks).strip()) for _ in range(3)]
                badge = list(reduce(lambda x, y: x.intersection(y), three_lines))[0]
                priority_sum += ascii_letters.index(badge) + 1
        except StopIteration:
            pass
    print(priority_sum)


run1()
run2()

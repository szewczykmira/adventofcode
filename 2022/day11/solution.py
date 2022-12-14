from dataclasses import dataclass, field
from itertools import cycle
from operator import mul, add
from typing import Callable, Dict, List, Tuple

INPUT_FILE = "input.txt"

BUFFER = list()


@dataclass
class Monkey:
    name: int
    items: List[int]
    operation: Tuple[Callable[[int, int], int], str]
    divisible_by: int
    if_true: int
    if_false: int
    count: int = field(init=False, default=0)

    def inspect_item(self, worry_level: int) -> Tuple[int, int]:
        self.count += 1
        op, value = self.operation
        value = worry_level if value == "old" else int(value)
        worry_level = op(worry_level, value) // 3
        if (worry_level % self.divisible_by) == 0:
            return self.if_true, worry_level
        return self.if_false, worry_level

    def catch_element(self, worry_level: int):
        self.items.append(worry_level)

    def summary(self):
        return f"Monkey {self.name} inspected items {self.count} times."


monkeys: Dict[int, Monkey] = dict()


def parse_name(item: str):
    BUFFER.append(int(item.strip().removeprefix("Monkey ").removesuffix(":")[-1]))


def parse_starting_items(line: str):
    res = list(map(int, line.removeprefix("  Starting items: ").strip().split(", ")))
    BUFFER.append(res)


def parse_operation(line: str):
    BUFFER.append(line.strip().removeprefix("Operation: ").split(" = ")[-1].split(" "))


def get_test(line: str):
    BUFFER.append(int(line.strip().removeprefix("Test: divisible by ")))


def throw_to_monkey(line: str):
    if line.strip().startswith("If true:"):
        BUFFER.append(int(line.strip().removeprefix("If true: throw to monkey ")))
    else:
        BUFFER.append(int(line.strip().removeprefix("If false: throw to monkey ")))


def sumup(line):
    _, op, val = BUFFER[2]
    op = mul if op == "*" else add
    monkey = Monkey(
        name=BUFFER[0],
        items=BUFFER[1],
        operation=(op, val),
        divisible_by=BUFFER[3],
        if_true=BUFFER[4],
        if_false=BUFFER[5],
    )
    monkeys[monkey.name] = monkey
    BUFFER.clear()


def round(monkey: Monkey):
    while monkey.items:
        throw_to, worry_level = monkey.inspect_item(monkey.items.pop(0))
        monkeys[throw_to].catch_element(worry_level)


with open(INPUT_FILE) as flying_monkeys:
    for line, func in zip(
        flying_monkeys,
        cycle(
            [
                parse_name,
                parse_starting_items,
                parse_operation,
                get_test,
                throw_to_monkey,
                throw_to_monkey,
                sumup,
            ]
        ),
    ):
        func(line)
sumup("")

for _ in range(20):
    for monkey in monkeys.values():
        round(monkey)

x1, x2 = sorted([x.count for x in monkeys.values()], reverse=True)[:2]

print(x1 * x2)

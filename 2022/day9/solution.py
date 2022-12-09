from dataclasses import dataclass, field
from typing import Tuple, Set


@dataclass
class Position:
    x: int
    y: int

    visited: Set[Tuple[int, int]] = field(default_factory=set)

    def __post_init__(self):
        self.visit()

    def visit(self):
        self.visited.add((self.x, self.y))

    @property
    def repr(self) -> Tuple[int, int]:
        return self.x, self.y

    def move_left(self):
        self.y -= 1
        self.visit()

    def move_right(self):
        self.y += 1
        self.visit()

    def move_up(self):
        self.x -= 1
        self.visit()

    def move_down(self):
        self.x += 1
        self.visit()

    @staticmethod
    def are_touching(x: int, y: int, other: "Position") -> bool:
        touchy = [(x - 1, y), (x + 1, y),
                  (x, y - 1), (x, y + 1),
                  (x + 1, y + 1), (x + 1, y - 1),
                  (x - 1, y + 1), (x - 1, y - 1),
                  (x, y)]
        return other.repr in touchy

    def keep_up(self, other: "Position"):
        if self.are_touching(self.x, self.y, other):
            return
        if other.x == self.x and abs(self.y - other.y) == 2:
            self.y = self.y + (1 if self.y < other.y else -1)
        elif other.y == self.y and abs(self.x - other.x) == 2:
            self.x = self.x + (1 if self.x < other.x else -1)
        else:
            options = [(self.x + 1, self.y + 1), (self.x + 1, self.y - 1),
                       (self.x - 1, self.y + 1), (self.x - 1, self.y - 1)]
            self.x, self.y = \
                [option for option in options if self.are_touching(*option, other)][0]
        self.visit()
        return


INPUT_FILE = "input.txt"

head = Position(0, 0)
tail = Position(0, 0)

with open(INPUT_FILE) as directions:
    for data in directions:
        print(data)
        direction, steps = data.strip().split(" ")
        for _ in range(int(steps)):
            match direction:
                case "L":
                    head.move_left()
                case "R":
                    head.move_right()
                case "U":
                    head.move_up()
                case "D":
                    head.move_down()
            tail.keep_up(head)
            print(f"H: {head.repr} T:{tail.repr}")

print(len(tail.visited))

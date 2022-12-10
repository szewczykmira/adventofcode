from pprint import pprint

INPUT_FILE = "test_input.txt"

X = 1
CYCLE = 0
during_process = False

searched_cycles = [20, 60, 100, 140, 180, 220]
values = []

CRT = [["."] * 40 for _ in range(6)]


def check_cycle(x: int):
    if CYCLE in searched_cycles:
        values.append(X)
    _, x_mod = divmod(X, 40)
    c_div, c_mod = divmod(CYCLE - 1, 40)
    if c_mod in [x_mod - 1, x_mod + 1, x_mod]:
        CRT[c_div][c_mod - 1] = "#"
    print(f"DRAW! {CYCLE} {X} {CRT[c_div][c_mod - 1]}")


with open(INPUT_FILE) as instructions:
    for instruction in instructions:
        match instruction.strip().split(" "):
            case [noop]:
                CYCLE += 1
                check_cycle(X)
            case ["addx", value]:
                for _ in range(2):
                    CYCLE += 1
                    check_cycle(X)
                X += int(value)


result = 0
for cycle, value in zip(searched_cycles, values):
    result += cycle * value
print(result)
# 13140

for x in CRT:
    print("".join(x))
from typing import List

INPUT_FILE = "input.txt"


def cleanup_data(stack_data) -> List[List[str]]:
    how_many = int(stack_data[-1][-1])
    stacks = [list() for _ in range(how_many)]
    stack_data = stack_data[:-1]

    for level in stack_data[::-1]:
        for i in range(how_many):
            try:
                value = level[i * 4 + 1]
            except IndexError:
                continue
            if not value == " ":
                stacks[i].append(value)
    return stacks


with open(INPUT_FILE) as data:
    stack_data = []
    for line in data:
        if len(line) == 1:
            break
        stack_data.append(line[:-1])

    stacks = cleanup_data(stack_data)

    for line in data:
        _, how_many, _, from_stack, _, to_stack = line.strip().split(" ")
        data = []
        for _ in range(int(how_many)):
            data.append(stacks[int(from_stack) - 1].pop())
        stacks[int(to_stack) - 1].extend(data[::-1])

print("".join([stack[-1] for stack in stacks]))

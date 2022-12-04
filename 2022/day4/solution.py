INPUT_FILE = "input.txt"

with open(INPUT_FILE) as elfs:
    part1 = 0
    part2 = 0
    for ranges in elfs:
        first, second = ranges.split(",")
        first_fst, first_sec = first.split("-")
        first_range = set(range(int(first_fst), int(first_sec) + 1))
        second_fst, second_sec = second.split("-")
        second_range = set(range(int(second_fst), int(second_sec) + 1))
        if first_range.issubset(second_range) or second_range.issubset(first_range):
            part1 += 1

        if first_range.intersection(second_range):
            part2 += 1

print(f"{part1=}")
print(f"{part2=}")

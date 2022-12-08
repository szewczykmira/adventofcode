INPUT_FILE = "input.txt"

with open(INPUT_FILE) as trees:
    trees = [[int(x) for x in line.strip()] for line in trees.readlines()]

visible = len(trees[0]) * 2 + len(trees) * 2 - 4

for i in range(1, len(trees) - 1):
    for j in range(1, len(trees) - 1):
        tree = trees[i][j]
        print(f"({i}, {j}): {tree}")
        max_left = max(trees[i][:j])
        max_right = max(trees[i][j + 1:])
        max_up = max([trees[x][j] for x in range(0, i)])
        max_down = max([trees[x][j] for x in range(i + 1, len(trees))])

        if any([x < tree for x in [max_up, max_right, max_left, max_down]]):
            visible += 1

print(visible)

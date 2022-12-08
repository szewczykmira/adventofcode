from functools import reduce

INPUT_FILE = "input.txt"

with open(INPUT_FILE) as trees:
    trees = [[int(x) for x in line.strip()] for line in trees.readlines()]

visible = len(trees[0]) * 2 + len(trees) * 2 - 4

scenic_score = 0

for i in range(1, len(trees) - 1):
    for j in range(1, len(trees) - 1):
        tree = trees[i][j]
        print(f"({i}, {j}): {tree}")
        # left = trees[i][:j][::-1]
        # right = trees[i][j + 1:]
        up = [trees[x][j] for x in range(0, i)][::-1]
        down = [trees[x][j] for x in range(i + 1, len(trees))]
        scores = []
        for ind, l in enumerate(trees[i][:j][::-1], start=1):
            if l >= tree:
                scores.append(ind)
                break
        else:
            scores.append(len(trees[i][:j]))
        for ind, r in enumerate(trees[i][j + 1:], start=1):
            if r >= tree:
                scores.append(ind)
                break
        else:
            scores.append(len(trees[i][j + 1:]))
        for ind, u in enumerate(up, start=1):
            if u >= tree:
                scores.append(ind)
                break
        else:
            scores.append(len(up))

        for ind, u in enumerate(down, start=1):
            if u >= tree:
                scores.append(ind)
                break
        else:
            scores.append(len(down))

        scenic_score = max(scenic_score, reduce(lambda x, y: x * y, scores))

print(scenic_score)

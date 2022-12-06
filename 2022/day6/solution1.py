INPUT_FILE = "input.txt"

with open(INPUT_FILE) as stream:
    buffer = stream.read()

for i in range(len(buffer) - 14):
    marker = buffer[i: i + 14]
    if len(set(marker)) == 14:
        break

print(i + 14)

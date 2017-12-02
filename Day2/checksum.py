def parse_file(filename='input.txt'):
    data = []
    with open(filename, 'r') as info:
        for elem in info.readlines():
            current = [int(val) for val in elem.strip().split('\t')]
            min_value, max_value = min(current), max(current)
            data.append(max_value - min_value)
    return sum(data, 0)

print(parse_file())

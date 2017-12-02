def is_divisible(data):
    for i, elem in enumerate(data):
        for bigger in data[i+1:]:
            if bigger % elem == 0:
                return bigger / elem
    return 0

def parse_file(filename='input.txt'):
    data = 0
    with open(filename, 'r') as info:
        for elem in info.readlines():
            current = sorted(
                [int(val) for val in elem.strip().split('\t')])
            data += is_divisible(current)
    return data

print(parse_file())

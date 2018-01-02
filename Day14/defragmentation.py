from collections import namedtuple
from functools import reduce


def parse_input(sequence):
    sequence = [ord(d) for d in sequence]
    sequence.extend([17, 31, 73, 47, 23])
    return sequence*64

def xor_data(data):
    result = []
    for i in range(0, len(data), 16):
        result.append(reduce(lambda a,b: a^b, data[i:i+16]))
    return ['{:02x}'.format(elem, 8) for elem in result]

def hash(sequence):
    data = list(range(0,256))
    sequence = parse_input(sequence)
    current_position = 0
    skip_size = 0
    for length in sequence:
        last_in_seq = current_position + length
        if length > 1:
            if current_position + length < len(data):
                data[current_position:last_in_seq] = list(reversed(data[current_position:last_in_seq]))
            else:
                modi = last_in_seq % len(data)
                to_parse = data[current_position:]
                to_parse.extend(data[:modi])
                to_parse = list(reversed(to_parse))
                buf = len(data) - current_position
                data[current_position:] = to_parse[:buf]
                data[:modi] = to_parse[buf:]

        current_position = (current_position + length + skip_size) % len(data)
        skip_size += 1
    return ''.join(xor_data(data))


def to_bin(input):
    return ''.join([bin(int(elem, 16))[2:].zfill(4) for elem in input])


def hashes_to_bin(data):
    return [to_bin(elem) for elem in create_all_hashes(data)]


def create_all_hashes(data):
    results = []
    for i in range(0, 128):
        results.append(hash(f'{data}-{i}'))
    return results


def ones(input):
    return len(list(filter(lambda x: x=='1', input)))


def find_ones(data):
    return sum(ones(elem) for elem in hashes_to_bin(data))


class Point:
    def __init__(self, row, column, parent):
        self.row = row
        self.column = column
        self.parent = parent

    def is_it(self, row, column):
        return (row == self.row) and (column == self.column)

    def __str__(self):
        return f"({self.row}, {self.column}): {self.parent}"

    def __repr__(self):
        return str(self)

    def __eq__(self, other):
        return self.row == other.row and self.column == other.column

    def is_neighbour(self, other):
        if self.row == other.row and self.column == (other.column + 1):
            return True
        return self.column == other.column and self.row == (other.row + 1)


class UnionFind:
    def __init__(self, value):
        self.hashes = hashes_to_bin(value)
        self.data = self.prepare()

    def prepare(self):
        iterator = 0
        data = []
        for row in range(0, 128):
            for column in range(0, 128):
                if self.hashes[row][column] == '1':
                    data.append(Point(column, row, iterator))
                    iterator += 1
        return data

    def union(self, groups):
        if len(groups) < 2:
            return
        main_group = groups[0]
        for elem in self.data:
            if elem.parent in groups[1:]:
                elem.parent = main_group

    def walk(self):
        for position in range(0, len(self.data)):
            elem = self.data[position]
            groups = [elem.parent]
            for value in range(0, position):
                other = self.data[value]
                if elem.is_neighbour(other):
                    groups.append(other.parent)
            self.union(groups)

    def __str__(self):
        return str(self.data)

    def how_many(self):
        data = set()
        for item in self.data:
            data.add(item.parent)
        return len(data)


uf = UnionFind('hxtvlmkl')
uf.walk()
print(uf.how_many())

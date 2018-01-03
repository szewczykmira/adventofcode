DIVIDER = 2147483647


class Generator:
    def __init__(self, factor, starts_with, divider=None):
        self.factor = factor
        self.prev_result = starts_with
        self.divider = divider
        self.values = []

    def generate_value(self):
        value = (self.prev_result * self.factor) % DIVIDER
        if not self.divider:
            return value
        while True:
            if value % self.divider == 0:
                return value
            value = (value * self.factor) % DIVIDER

    def next_value(self):
        value = self.generate_value()
        self.prev_result = value
        return value

    def to_bin(self):
        return bin(self.prev_result)[2:][-16:]

def main(how_many, gen_a, gen_b):
    same = 0
    gen_a = Generator(16807, gen_a)
    gen_b = Generator(48271, gen_b)
    generators = [gen_a, gen_b]
    for i in range(0, how_many):
        for gen in generators:
            gen.next_value()
        if gen_a.to_bin() == gen_b.to_bin():
            same += 1
    return same

def part2(how_many, gen_a, gen_b):
    same = 0
    gen_a = Generator(16807, gen_a, 4)
    gen_b = Generator(48271, gen_b, 8)
    generators = [gen_a, gen_b]
    for i in range(0, how_many):
        for gen in generators:
            gen.next_value()
        if gen_a.to_bin() == gen_b.to_bin():
            same += 1
    return same


#print(main(5, 65, 8921))
#print(main(40000000, 65, 8921))
#print(main(40000000, 289, 629))
#print(part2(5000000, 65, 8921))
print(part2(5000000, 289, 629))

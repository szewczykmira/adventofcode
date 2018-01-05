from collections import Counter
from string import ascii_lowercase
POSITIONS = ascii_lowercase[:16]

SLASH = '/'
SPIN = 's' # how many from end
EXCHANGE = 'x' # index
PARTNER = 'p' # name

class Dancing:
    def __init__(self, data, items=None):
        self.data = data
        items = items if items else POSITIONS
        self.items = list(items)
        with open(self.data, 'r') as instructions:
            for line in instructions.readlines():
                line = line.strip()
                steps = line.split(',')
        self.steps = steps

    def take_step(self, step):
        what = step[0]
        step = step[1:]
        if what == SPIN:
            step = int(step) * -1
            self.items = self.items[step:] + self.items[:step]
            return
        if what == EXCHANGE:
            fst, snd = map(int, step.split(SLASH))
            self.items[fst], self.items[snd] = self.items[snd], self.items[fst]
            return
        if what == PARTNER:
            fst, snd = map(lambda x: self.items.index(x), step.split(SLASH))
            self.items[fst], self.items[snd] = self.items[snd], self.items[fst]
            return

    def dance(self):
        for step in self.steps:
            self.take_step(step)

    def make_many(self, times=1000000000):
        seen = []
        for i in range(times):
            if ''.join(self.items) in seen:
                return seen[times % i]

            seen.append(''.join(self.items))
            self.dance()


dancer = Dancing('input.txt')
print(dancer.make_many())

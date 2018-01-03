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
        with open(self.data, 'r') as instructions:
            for line in instructions.readlines():
                line = line.strip()
                steps = line.split(',')
                for step in steps:
                    self.take_step(step)
        print(''.join(self.items))


dancer = Dancing('input.txt')
dancer.dance()

class Grid:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

    def __add__(self, other):
        self.x += other.x
        self.y += other.y
        return self

    def __str__(self):
        return f'x:{self.x} y:{self.y}'

NORTH = 'n'
NORTH_STEP = Grid(0, 2)
NORTHEAST = 'ne'
NE_STEP = Grid(1, 1)
NORTHWEST = 'nw'
NW_STEP = Grid(-1, 1)
SOUTH = 's'
SOUTH_STEP = Grid(0, -2)
SOUTHEAST = 'se'
SE_STEP = Grid(1, -1)
SOUTHWEST = 'sw'
SW_STEP = Grid(-1, -1)

STEPS = {NORTH: NORTH_STEP, NORTHEAST: NE_STEP, NORTHWEST: NW_STEP,
        SOUTH: SOUTH_STEP, SOUTHEAST: SE_STEP, SOUTHWEST: SW_STEP}

START = Grid(0, 0)

def find_steps(position):
    steps = 0
    current_position = position
    if position.x < 0:
        last = NORTH
        if position.y > 0:
            start = NORTHWEST
        else:
            start = NORTHEAST
    else:
        last = SOUTH
        if position.y > 0:
            start = SOUTHWEST
        else:
            start = SOUTHEAST

    while not current_position.x == 0:
        steps += 1
        current_position += STEPS[start]

    while not current_position.y == 0:
        steps += 1
        current_position += STEPS[last]

    return steps

def read_data(data='input.txt'):
    with open(data, 'r') as steps:
        return steps.readlines()[0].strip().split(',')

def walk(steps):
    curr_position = START
    for step in steps:
        curr_position += STEPS[step]
    return curr_position

#print(find_steps(walk(['se','sw','se','sw','sw'])))
print(find_steps(walk(read_data())))

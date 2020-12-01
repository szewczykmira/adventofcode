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

    def tuple(self):
        return (self.x, self.y)

    def abs(self):
        return Grid(abs(self.x), abs(self.y))

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
    current_position = position.abs()
    if current_position.x > current_position.y:
        return current_position.x
    return current_position.x + (current_position.y - current_position.x) / 2


def read_data(data='input.txt'):
    with open(data, 'r') as steps:
        return steps.readlines()[0].strip().split(',')

def find_max(positions):
    max_distance = 0
    for position in positions:
        position = Grid(*position)
        distance = find_steps(position)
        if distance > max_distance:
            max_distance = distance
    print('Max_distance', max_distance)

def walk(steps):
    curr_position = START
    positions = set()
    for step in steps:
        curr_position += STEPS[step]
        positions.add(curr_position.tuple())
    find_max(positions)
    return curr_position

print(find_steps(walk(read_data())))

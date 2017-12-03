UP = [-1, 0]
DOWN = [1, 0]
LEFT = [0, -1]
RIGHT = [0, 1]

DATA = {(0,0): 1}

FRIENDS = [[-1,-1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

def get_friends_sum(elem):
    friends = [DATA.get((elem[0] + friend[0], elem[1] + friend[1]), 0)
                for friend in FRIENDS]
    return sum(friends)

def walk_circle(times):
    route = []
    for i in range(times):
        route.append(RIGHT)
    for i in range(times):
        route.append(UP)
    for i in range(times+1):
        route.append(LEFT)
    for i in range(times+1):
        route.append(DOWN)
    return route


def walk(elem):
    iterator = 1
    last = (0, 0)
    while True:
        circle = walk_circle(iterator)
        for move in circle:
            current = (last[0] + move[0], last[1] + move[1])
            value = get_friends_sum(current)
            if value > elem:
                return value
            last = current
            DATA[current] = value
        iterator += 2

print(walk(368078))

from collections import namedtuple

Program = namedtuple('Program', ['weight', 'sons'])

class MemoryTree:
    TOWER = {}
    ARROW = ' -> '
    def __init__(self, input='input.txt'):
        with open(input, 'r') as data_input:
            for line in data_input.readlines():
                if self.ARROW in line:
                    program, sons = line.split(self.ARROW)
                    sons = sons.strip().split(', ')
                else:
                    program = line
                    sons = []
                name, weight = program.split(' ')
                self.TOWER[name] = Program(weight=weight[1:-1], sons=sons)

    def __str__(self):
        return str(self.TOWER)

    @property
    def sons(self):
        sons = set()
        for name, program in self.TOWER.items():
            if program.sons:
                sons.update(program.sons)
        return sons

    def remove_sons(self):
        for son in self.sons:
            del self.TOWER[son]

    def find_father(self):
        self.remove_sons()
        if len(self.TOWER) == 1:
            return list(self.TOWER.keys())[0]



tree = MemoryTree()
print(tree.find_father())

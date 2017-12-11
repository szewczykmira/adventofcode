from collections import namedtuple, Counter

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
                    program = line.strip()
                    sons = []
                name, weight = program.split(' ')
                self.TOWER[name] = Program(
                    weight=int(weight[1:-1].strip()), sons=sons)

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
        return list(set(self.TOWER.keys()) - self.sons)[0]

    def balance(self, elem):
        elem = self.TOWER[elem]
        sons = sum(self.balance(son) for son in elem.sons)
        result = elem.weight + sons
        return result

    def find_balance(self, node):
        node_elem = self.TOWER[node]
        sons = [self.balance(son) for son in node_elem.sons]


tree = MemoryTree()
print(tree.find_father())

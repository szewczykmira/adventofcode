from collections import namedtuple, Counter

Program = namedtuple('Program', ['weight', 'sons'])
Node = namedtuple('Node', ['name', 'sum', 'weight', 'sons', 'equal'])
Leaf = namedtuple('Leaf', ['name', 'sum', 'equal'])

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
        node = self.TOWER[elem]
        if node.sons:
            sons = [self.balance(son) for son in node.sons]
            sons_weights = [son.sum for son in sons]
            are_equal = len(set(sons_weights)) == 1
            return Node(
                elem, node.weight + sum(sons_weights), node.weight, sons, are_equal)
        return Leaf(elem, node.weight, True)

    def is_balanced(self, balanced):
        sums = [son.sum for son in balanced.sons]
        if set(sums) == 1:
            return balanced
        count = Counter(sums)
        count.subtract()
        different = [x[0] for x in dict(count).items() if x[1] == 1][0]
        different = [son for son in balanced.sons if son.sum == different][0]
        diff_sons_sums = [son.sum for son in different.sons]
        if len(set(diff_sons_sums)) == 1:
            return [(son.weight, son.sum) for son in balanced.sons]
        return self.is_balanced(different)


tree = MemoryTree()
father = tree.find_father()
balanced = tree.balance(father)
print(tree.is_balanced(balanced))

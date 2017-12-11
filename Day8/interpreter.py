from collections import namedtuple
import operator

Line = namedtuple('Line', ['register', 'operation', 'value', 'statement'])

# how does it look: register to modify, operation

class CPU:
    STACK = {}
    INCREASE = 'inc'
    DECREASE = 'dec'

    EQ = '=='
    GTE = '>='
    LTE = '<='
    GT = '>'
    LT = '<'
    NE = '!='

    OPERATIONS = {INCREASE: operator.add, DECREASE: operator.sub}
    COMPARISION = {
        EQ: operator.eq,
        GTE: operator.ge,
        GT: operator.gt,
        LTE: operator.le,
        LT: operator.lt,
        NE: operator.ne}

    def __init__(self, input_data='test.txt'):
        self.data = input_data

    def register(self, elem):
        if elem.isdigit() or elem[1:].isdigit():
            return int(elem)
        return self.STACK.get(elem, 0)

    def keep(self, register, elem):
        self.STACK[register] = elem

    def parse_information(self, line):
        line = line.strip().split(' ', 3)
        return Line(*line)

    def parse_if(self, statement):
        a, op, b = statement
        a = self.register(a)
        b = self.register(b)
        return self.COMPARISION[op](a, b)

    def calculate_line(self, line):
        register = self.register(line.register)
        statement = line.statement[3:].strip().split(' ')
        if self.parse_if(statement):
            self.keep(line.register, self.OPERATIONS[line.operation](register, int(line.value)))

    def calculate(self):
        with open(self.data, 'r') as info:
            for line in info.readlines():
                information = self.parse_information(line)
                self.calculate_line(information)

cpu = CPU('input.txt')
cpu.calculate()
print(max(cpu.STACK.values()))

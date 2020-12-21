# pip install arpeggio

from arpeggio import (
    ZeroOrMore,
    OneOrMore,
    EOF,
    ParserPython,
    visit_parse_tree,
    PTNodeVisitor,
)
from arpeggio import RegExMatch as _
from operator import add, mul


def number():
    return _(r"\d+")


def factor():
    return [number, ("(", expression, ")")]


def expression():
    return factor, ZeroOrMore(["*", "+"], factor)


def calc():
    return expression, EOF


class Visitor(PTNodeVisitor):
    def get_operation(self, val):
        if val == "*":
            return mul
        return add

    def visit_number(self, node, children):
        return int(node.value)

    def visit_factor(self, node, children):
        if len(children) == 1:
            return children[0]

    def visit_expression(self, node, children):
        first = children.pop(0)
        while children:
            operator = children.pop(0)
            second = children.pop(0)
            first = self.get_operation(operator)(first, second)
        return first

    def visiting_calc(self, node, children):
        return children[0]


parser = ParserPython(calc)


def get_value(calculation):
    return visit_parse_tree(parser.parse(calculation), Visitor())


assert get_value("2 * 3 + (4 * 5)") == 26
assert get_value("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
assert get_value("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 12240
assert get_value("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13632

with open("input_18.txt", "r") as homework:
    print(sum([get_value(line) for line in homework.readlines()]))

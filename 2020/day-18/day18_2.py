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
import operator


def number():
    return _(r"\d+")


def factor():
    return [number, ("(", expression, ")")]


def add():
    return factor, ZeroOrMore(["+"], factor)


def expression():
    return add, ZeroOrMore(["*"], add)


def calc():
    return expression, EOF

class Visitor(PTNodeVisitor):

    def visit_number(self, node, children):
        return int(node.value)

    def visit_factor(self, node, children):
        if len(children) == 1:
            return children[0]
    
    def visit_add(self, node, children):
        first = children.pop(0)
        while children:
            _ = children.pop(0)
            second = children.pop(0)
            first = operator.add(first, second)
        return first

    def visit_expression(self, node, children):
        first = children.pop(0)
        while children:
            _ = children.pop(0)
            second = children.pop(0)
            first = operator.mul(first, second)
        return first

    def visiting_calc(self, node, children):
        return children[0]


parser = ParserPython(calc)


def get_value(calculation):
    return visit_parse_tree(parser.parse(calculation), Visitor())


assert get_value("1 + (2 * 3) + (4 * (5 + 6))") == 51
assert get_value("2 * 3 + (4 * 5)") == 46
assert get_value("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 1445
assert get_value("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 23340

with open("input_18.txt", "r") as homework:
    print(sum([get_value(line) for line in homework.readlines()]))

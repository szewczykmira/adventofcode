from dataclasses import dataclass, field
from typing import List, Optional, Union

INPUT_FILE = "input.txt"

WHOLE_FILESYSTEM = 70000000
REQUIRED = 30000000


@dataclass()
class File:
    name: str
    size: int
    parent: "Directory"


@dataclass()
class Directory:
    name: str
    total_size: int = 0
    parent: Optional["Directory"] = None
    children: List[Union["File", "Directory"]] = field(default_factory=list)

    def find_directory(self, name: str) -> Optional["Directory"]:
        for child in self.children:
            if isinstance(child, Directory) and child.name == name:
                return child

    def add_child_dir(self, name):
        self.children.append(Directory(name, parent=self))

    def add_file(self, size: int, name: str):
        self.children.append(File(name=name, size=size, parent=self))

    def calculate_size(self):
        for child in self.children:
            if isinstance(child, File):
                self.total_size += child.size
            else:
                child.calculate_size()
                self.total_size += child.total_size

    def get_children_below(self, x: int):
        solution = []
        for child in self.children:
            if isinstance(child, File):
                continue
            if child.total_size < x:
                solution.append(child)
            solution.extend(child.get_children_below(x))
        return solution


start_point = Directory("/")

curr_directory = start_point
directories_paths = dict()

with open(INPUT_FILE) as terminal:
    for line in terminal:
        match line.split():
            case ["$", "cd", directory]:
                if directory == "..":
                    curr_directory = curr_directory.parent
                elif directory == "/":
                    pass
                else:
                    curr_directory = curr_directory.find_directory(directory)
            case ["$", "ls"]:
                pass
            case ["dir", directory_name]:
                curr_directory.add_child_dir(directory_name)
            case [size, name]:
                curr_directory.add_file(int(size), name)

start_point.calculate_size()
I_NEED = start_point.total_size - (WHOLE_FILESYSTEM - REQUIRED)
# print(sum([x.total_size for x in start_point.get_children_below(100000)]))

options = [start_point.total_size]
to_see = start_point.children
while to_see:
    item = to_see.pop(0)
    if isinstance(item, File):
        continue
    if item.total_size >= I_NEED:
        options.append(item.total_size)
        to_see.extend(item.children)

print(min(options))

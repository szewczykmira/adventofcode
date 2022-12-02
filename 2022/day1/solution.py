INPUT_FILENAME = "input1.txt"

def run():
    max1 = 0
    max2 = 0
    max3 = 0
    current_elf = 0
    with open(INPUT_FILENAME) as elfs_baggage:
        for line in elfs_baggage.readlines():
            line = line.strip()
            if line.isdecimal():
                current_elf += int(line)
            else:
                max1, max2, max3, _ = sorted([max1, max2, max3, current_elf], reverse=True)
                current_elf = 0
    return [max1, max2, max3]

def run1():
    return run()[0]

def run2():
    return sum(run())

if __name__ == "__main__":
    print(run1())
    print(run2())
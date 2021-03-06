from itertools import count
FIREWALL = {}

class Firewall:
    SEVERITY = 0

    def __init__(self, input_data):
        with open(input_data, 'r') as firewall_input:
            for line in firewall_input.readlines():
                line = line.strip().split(': ')
                FIREWALL[int(line[0])] = int(line[-1])
        self.last_layer = int(line[0])

    @property
    def firewall(self):
        return FIREWALL

    @property
    def depths(self):
        return list(sorted(self.firewall.keys()))

    def current_range_is_zero(self, layer, picoseconds):
        depth_range = self.firewall.get(layer)
        if not depth_range:
            return False
        will_be_zero_for = (depth_range - 1) * 2
        if picoseconds % will_be_zero_for == 0:
            return True
        return False

    @property
    def severity(self):
        return self.SEVERITY

    def get_cought(self, depth):
        depth_range = self.firewall[depth]
        severity = depth * depth_range
        self.SEVERITY += severity

    def clean_severity(self):
        self.SEVERITY = 0

    def walk(self, delay=0, search=False):
        PICOSECONDS = 0 + delay
        for layer in range(0, self.last_layer+1):
            current_range = self.current_range_is_zero(layer, PICOSECONDS)
            if current_range:
                self.get_cought(layer)
                if search:
                    return False
            PICOSECONDS += 1
        return True

    def best_delay(self):
        for delay in count(1):
            if not self.walk(delay, search=True):
                self.clean_severity()
                continue
            return delay


firewall = Firewall('input.txt')

print(firewall.best_delay())

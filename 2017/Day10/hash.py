from functools import reduce

def parse_input(sequence):
    sequence = [ord(d) for d in sequence]
    sequence.extend([17, 31, 73, 47, 23])
    return sequence*64

def xor_data(data):
    result = []
    for i in range(0, len(data), 16):
        result.append(reduce(lambda a,b: a^b, data[i:i+16]))
    return ['{:02x}'.format(elem, 8) for elem in result]

def hash(sequence, data=list(range(0,256))):
    sequence = parse_input(sequence)
    current_position = 0
    skip_size = 0
    for length in sequence:
        last_in_seq = current_position + length
        if length > 1:
            if current_position + length < len(data):
                data[current_position:last_in_seq] = list(reversed(data[current_position:last_in_seq]))
            else:
                modi = last_in_seq % len(data)
                to_parse = data[current_position:]
                to_parse.extend(data[:modi])
                to_parse = list(reversed(to_parse))
                buf = len(data) - current_position
                data[current_position:] = to_parse[:buf]
                data[:modi] = to_parse[buf:]

        current_position = (current_position + length + skip_size) % len(data)
        skip_size += 1
    return ''.join(xor_data(data))

#hash(list(range(0,256)), [94,84,0,79,2,27,81,1,123,93,218,23,103,255,254,243])
print(hash('94,84,0,79,2,27,81,1,123,93,218,23,103,255,254,243'))

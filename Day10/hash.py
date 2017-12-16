def hash(data, sequence):
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
    return data

hash(list(range(0,256)), [94,84,0,79,2,27,81,1,123,93,218,23,103,255,254,243])

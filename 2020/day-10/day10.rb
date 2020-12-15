INPUT_FILE = "input_10.txt"
OUTLET = 0

def one
    data = File.read(INPUT_FILE).lines.map(&:to_i).sort
    diff_1 = data[0] == 1 ? 1 : 0
    diff_3 = data[0] == 3 ? 2 : 1
    data[1..].each_with_index do |elem, index |
        diff = elem - data[index]
        diff_1 += diff == 1 ? 1 : 0
        diff_3 += diff == 3 ? 1 : 0
    end
    diff_1 * diff_3
end


def sublist_as_dict(values)
    result = {0 => 1}
    values[1..].each_with_index do |value, index|
        tmp_result = 0
        [0,1,2].each do |i|
            prev = values[index - i]
            diff = value - prev
            tmp_result += result[prev] if diff <= 3
            break if (index - i) == 0
        end
        result[value] = tmp_result
    end
    result[values[-1]]
end


def two
    data = File.read(INPUT_FILE).lines.map(&:to_i).sort
    data.unshift 0
    data << (data[-1] + 3)
    sublist_as_dict(data)
end

p one
p two
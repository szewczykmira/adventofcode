require 'set'

EXPECTED_VALUE = 2020


def one
    read_values = Set[]
    multipla = 1

    File.read("input_1_1.txt").each_line do |value|
        ivalue = value.to_i
        negative = EXPECTED_VALUE - ivalue
        if read_values.include? negative
            multipla = negative * ivalue
        end
        read_values.add ivalue
    end
    multipla
end


def two
    read_values = Set[]
    recieved_sums = Hash[]
    multipla = 1
    File.read("input_1_2.txt").each_line do |value|
        ivalue = value.to_i
        negative = EXPECTED_VALUE - ivalue
        if recieved_sums.has_key? negative
            i, j = recieved_sums[negative]
            multipla = ivalue * i * j
            break
        end
        recieved_sums.merge!(read_values.map do |v|
            [v+ivalue, [v, ivalue]]
        end.to_h)
        read_values << ivalue
    end
    multipla
end

puts two

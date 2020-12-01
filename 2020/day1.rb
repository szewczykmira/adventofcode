require 'set'

EXPECTED_VALUE = 2020

def one
    read_values = Set[]
    File.read("input_1_1.txt").lines.lazy.map(&:to_i).each do |value|
        negative = EXPECTED_VALUE - value
        return negative * value if read_values.include? negative
        read_values << value
    end
end


def two
    read_values = Set[]
    received_sums = Hash[]
    File.read("input_1_2.txt").lines.lazy.map(&:to_i).each do |value|
        negative = EXPECTED_VALUE - value
        return [value, received_sums[negative]].flatten.reduce(:*) if received_sums.has_key? negative
        received_sums.merge! (read_values.map { |v| [v+value, [v, value]]}.to_h)
        read_values << value
    end
end

puts one
puts two

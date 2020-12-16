require 'set'

INPUT_FILE = "input_14.txt"

def prepare_mask(value)
  value.match(/mask = ([X01]+)/).captures[0].split("").each_with_index.filter { |v, index| v != "X" }
end

def gather_value(line, mask)
  address, value = line.match(/mem\[(\d+)\] = (\d+)$/).captures.map(&:to_i)
  value = "%036b" % value
  mask.each { |v, index| value[index] = v }
  [address, value.to_i(2)]
end

def one
  memory = Hash.new
  current_mask = []
  File.read(INPUT_FILE).lines.map(&:strip).each do |line|
    (current_mask = prepare_mask(line); next) if line.start_with? "mask"
    address, value = gather_value(line, current_mask)
    memory[address] = value
  end
  memory.values.reduce(:+)
end

def genarate_all_masks(line)
  o_mask = line.match(/mask = ([X01]+)/).captures[0].split("")
  o_mask = o_mask.each_with_index.map { |v, index| [index, v] }.filter { |i, v| v != "0" }.to_h
  masks = Set.new
  masks << o_mask
  indexes_of_x = o_mask.filter { |index, o| o == "X" }.keys
  indexes_of_x.each { |index| o_mask[index] = "0" }
  (1..(indexes_of_x.count)).each do |it|
    perms = indexes_of_x.permutation(it)
    perms.each do |indexes|
      c_mask = o_mask.dup
      indexes.each do |index|
        c_mask[index] = "1"
      end
      masks << c_mask
    end
  end
  masks
end

def gather_value_two(line, masks)
  address, value = line.match(/mem\[(\d+)\] = (\d+)$/).captures.map(&:to_i)
  address = "%036b" % address
  addresses = []
  masks.each do |mask|
    c_address = address.dup
    mask.each { |index, value| c_address[index] = value }
    addresses << c_address.to_i(2)
  end
  [addresses, value]
end

def two
  memory = Hash.new
  masks = []
  File.read(INPUT_FILE).lines.map(&:strip).each_with_index do |line, index|
    (masks = genarate_all_masks(line); next) if line.start_with? "mask"
    addresses, value = gather_value_two(line, masks)
    addresses.each do |addres|
      memory[addres] = value
    end
  end
  memory.values.reduce(:+)
end

p one
p two

INPUT_FILE = "input_8.txt"

class Operation
  attr_reader :counter, :type

  def initialize(type, value)
    @type = type
    @value = value
    @counter = 0
  end

  def call(index, acc)
    @counter += 1
    return [index + 1, acc += @value.to_i] if @type == "acc"
    return [index + @value.to_i, acc] if @type == "jmp"
    return [index + 1, acc] if @type == "nop"
  end

  def toggle
    value = @type == "jmp" ? "nop" : "jmp"
    @type = value
  end

  def clean
    @counter = 0
  end
end

def one
  lines = File.read(INPUT_FILE).lines.map(&:strip).map { |el| Operation.new(*el.split()) }
  acc = 0
  index = 0
  visited = [lines[0]]
  visited.each do |obj|
    break if obj.counter == 1

    index, acc = obj.call(index, acc)
    visited << lines[index]
  end
  acc
end

def walk(lines)
  acc = 0
  index = 0
  visited = [lines[0]]
  visited.each do |obj|
    break if obj.nil?
    return if obj.counter == 1

    index, acc = obj.call(index, acc)
    visited << lines[index]
  end
  acc
end

def two
  lines = File.read(INPUT_FILE).lines.map(&:strip).map { |el| Operation.new(*el.split()) }
  acc = 0
  lines.each_with_index do |obj, index|
    next if obj.type == "acc"

    obj.toggle
    acc = walk(lines)
    obj.toggle
    break unless acc.nil?

    lines.map(&:clean)
  end
  acc
end

p one
p two

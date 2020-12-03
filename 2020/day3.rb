OPEN_SQUARE = "."
TREE = "#"

def one_under(filename, slope)
  current_column = 0
  how_many_trees = 0
  File.read(filename).lines.lazy.each do |line|
    how_many_trees += 1 if line[current_column % (line.length - 1)] == TREE
    current_column += slope
  end
  how_many_trees
end

def get_slopes(filename, right, under)
  lines = File.read(filename).lines
  current_row = 0
  current_column = 0
  how_many_trees = 0
  while current_row < lines.length do
    line = lines[current_row]
    l_length = line.length
    how_many_trees += 1 if line[current_column % (l_length - 1)] == TREE
    current_row += under
    current_column += right
  end
  how_many_trees
end

def one
  one_under("input_3_1.txt", 3)
end

def two
  filename = "input_3_2.txt"
  walks = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  walks.map { |right, under| get_slopes(filename, right, under) }.reduce(1, :*)
end

puts one
puts two

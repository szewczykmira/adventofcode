TREE = "#"

def many_under(filename, slope, many)
  File.read(filename).lines.select.with_index do |line, index|
    line[(index / many) * slope % (line.length - 1)] == TREE and (index % many == 0)
  end.count
end

def one
  many_under("input_3_1.txt", 3, 1)
end

def two
  filename = "input_3_2.txt"
  walks = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  walks.map { |right, under| many_under(filename, right, under) }.reduce(:*)
end

puts one
puts two

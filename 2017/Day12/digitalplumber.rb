require 'set'
PIPES = Hash.new(nil)

def union(values)
  main_value = values[0]
  PIPES.each do |key, value|
    if values[1..values.length].include? value
      PIPES[key] = main_value
    end
  end
end

def parse_line(line)
  elem, edges = line.strip.split(' <-> ')
  elem = elem.to_i
  edges = edges.split(', ').map {|a| a.to_i}
  [elem, edges]
end

def add_to_pipe(line)
  elem, edges = parse_line(line)
  if edges.length == 1 && edges[0] == elem
    PIPES[elem] = elem
    return
  end

  edges = [elem] + edges
  values = edges.map {|edge| PIPES[edge]}
  values = values.select {|val| not val == nil}
  if values.length > 1
    union(values)
  end
  value = values[0] ? values[0] : edges[0]
  edges.each {|edge| PIPES[edge] = value}
end

def input_data(data)
  data = File.open(data)
  data.map {|line| add_to_pipe(line)}
end

def how_many
  value0 = PIPES[0]
  PIPES.select {|key, value| value == value0}.length
end

def group_counts
  PIPES.values.to_set.length
end

input_data 'input.txt'
puts group_counts

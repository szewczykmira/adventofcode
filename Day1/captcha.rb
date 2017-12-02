def file_to_array
  file = File.read('input.txt')
end

def main_func(data=nil)
  unless data
    data = file_to_array
  end
  data = data.chars
  sum = 0
  data.each_index do |elem|
    next_elem = elem + 1 == data.length ? 0 : elem + 1
    if data[elem] == data[next_elem]
      sum += data[elem].to_i
    end
  end
  sum
end

puts main_func('1122')
puts main_func('1111')
puts main_func('1234')
puts main_func('91212129')

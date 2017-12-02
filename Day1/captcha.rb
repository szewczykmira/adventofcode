def get_data(data=nil)
  data ? data.chars : File.read('input.txt').chars
end

def main_func(data=nil)
  data = get_data(data)
  sum = 0
  data.each_index do |i|
    if data[i].to_i == data[i-1].to_i
      sum += data[i].to_i
    end
  end
  sum
end

def test
  raise unless main_func('1122') == 3
  raise unless main_func('1111') == 4
  raise unless main_func('1234') == 0
  raise unless main_func('91212129') == 9
end

test
puts main_func

def get_data(data=nil)
  data ? data.chars : File.read('input.txt').rstrip.chars
end

def main_func(data=nil)
  data = get_data(data)
  sum = 0
  half = data.length / 2
  data.each_index do |i|
    if data[i].to_i == data[i-half].to_i
      sum += data[i].to_i
    end
  end
  sum
end

def test
  raise unless main_func('1212') == 6
  raise unless main_func('1221') == 0
  raise unless main_func('123425') == 4
  raise unless main_func('123123') == 12
  raise unless main_func('12131415') == 4
end

test
puts main_func

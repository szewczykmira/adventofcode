INPUT1 = "0,3,6"
INPUT2 = "1,3,2"
INPUT3 = "2,1,3"
INPUT4 = "1,2,3"
INPUT5 = "2,3,1"
INPUT6 = "3,2,1"

INPUT_ORIG = "5,2,8,16,18,0,1"

INPUT = INPUT_ORIG

def calculate(times)
  values = INPUT.split(",")[0..-2].each_with_index.map { |v, index| [v.to_i, index + 1] }.to_h
  prev_number = INPUT.split(",")[-1].to_i
  counter = values.count + 2
  while counter < times + 1
    number = (values.key? prev_number) ? ((counter - 1) - values[prev_number]) : 0
    values[prev_number] = counter - 1
    prev_number = number
    counter += 1
  end
  number
end

def one
  calculate(2020)
end

def two
  calculate(30000000)
end

p one
p two

def is_valid_1(line)
  *vals, letter, password = line.match(/(\d+)-(\d+) (\w{1}): (\w+)/).captures
  min, max = vals.map(&:to_i)
  (min..max).include? password.count(letter)
end

def is_valid_2(line)
  *vals, letter, password = line.match(/(\d+)-(\d+) (\w{1}): (\w+)/).captures
  first, sec = vals.map { |v| v.to_i - 1 }
  (password[first] == letter) ^ (password[sec] == letter)
end

def validator(filename, &func)
  File.read(filename).lines.select(&func).length
end

def one
  validator("input_2_1.txt", &method(:is_valid_1))
end

def two
  validator("input_2_2.txt", &method(:is_valid_2))
end

puts one
puts two

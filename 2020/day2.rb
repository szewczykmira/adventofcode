def is_valid_1(line)
  *vals, letter, password = line.match(/(\d+)-(\d+) (\w{1}): (\w+)/).captures
  min, max = vals.map(&:to_i)
  count = password.count letter
  min <= count and count <= max
end

def is_valid_2(line)
  *vals, letter, password = line.match(/(\d+)-(\d+) (\w{1}): (\w+)/).captures
  first, sec = vals.map { |v| v.to_i - 1 }
  at_first = (password[first] == letter and not password[sec] == letter)
  at_second = (not password[first] == letter and password[sec] == letter)
  at_first or at_second
end

def validator(filename, func)
  (File.read(filename).lines.map { |line| method(func).call(line) }).select! { |el| el }.length
end

def one
  validator("input_2_1.txt", :is_valid_1)
end

def two
  validator("input_2_2.txt", :is_valid_2)
end

puts one
puts two

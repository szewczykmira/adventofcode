require "set"
def one
  File.read("input_6.txt").split("\n\n").map { |v| v.gsub("\n", "").split("").to_set.length }.reduce(:+)
end

def two
  File.read("input_6.txt").split("\n\n").map do |v|
    v.split("\n").map { |answer| answer.split("").to_set }.reduce { |x, y| x.intersection y }.length
  end.reduce(:+)
end

p one
p two

require 'set'

def encode_seat(seat)
    row = seat[0..6].gsub("F", "0").gsub("B", "1").to_i(2)
    column = seat[7..].gsub("L", "0").gsub("R", "1").to_i(2)
    row*8 + column
end

def one
    File.read("input_5.txt").lines.map {|line| encode_seat line}.max
end

def two
    (45..953).to_set -  File.read("input_5.txt").lines.map {|line| encode_seat line}.to_set
end

p one
p two

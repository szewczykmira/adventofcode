require 'set'

GOLD = "shiny gold"
BAGS = Hash.new {|hsh, key| hsh[key] = Set.new() }
BAGS_TWO = Hash.new {|hsh, key| hsh[key] = [] }

class Bag
    attr_reader :number, :colour
    def initialize(inp)
        n, @colour = inp.split(" ", 2)
        @number = n.to_i
        @number += 1 if @number == 0
    end
end

def one
    File.read("input_7.txt").lines.each do |line|
        next if line.end_with? "no other bags.\n"
        current_color, inside = line.split(" bags contain ")
        [[".\n", ""], [" bags", ""], [" bag", ""]].map { |inp, out| inside.gsub!(inp, out) }
        inside.split(", ").map { |v| BAGS[v.split(" ", 2)[-1]] << current_color }
    end
    walk_through = BAGS[GOLD].to_a
    walk_through.each do |elem|
        walk_through.push(*BAGS[elem].to_a)
    end
    walk_through.to_set.length
end


def iteration(colour)
    bags = BAGS_TWO[colour]
    return 1 if bags.length == 0
    bags.map { |bag| bag.number * iteration(bag.colour) }.reduce(:+) + 1
end

def two
    File.read("input_7.txt").lines.each do |line|
        next if line.include? "no other bags."
        current_color, inside = line.split(" bags contain ")
        [[".\n", ""], [" bags", ""], [" bag", ""]].map { |inp, out| inside.gsub!(inp, out) }
        inside.split(", ").map { |v| BAGS_TWO[current_color] << Bag.new(v) }
    end
    iteration(GOLD) - 1
end


p one
p two
require 'set'

ACTIVE = "#"
INACTIVE = "."
INPUT_FILE = "input_17.txt"



def get_neighbours(cube, row, column)
    [
        [cube - 1, row - 1, column - 1],
        [cube - 1, row - 1, column],
        [cube - 1, row - 1, column + 1],
        [cube - 1, row, column - 1],
        [cube - 1, row, column],
        [cube - 1, row, column + 1],
        [cube - 1, row + 1, column - 1],
        [cube - 1, row + 1, column],
        [cube - 1, row + 1, column + 1],
        [cube, row - 1, column - 1],
        [cube, row - 1, column],
        [cube , row - 1, column + 1],
        [cube, row, column - 1],
        [cube, row, column + 1],
        [cube, row + 1, column - 1],
        [cube, row + 1, column],
        [cube, row + 1, column + 1],
        [cube + 1, row - 1, column - 1],
        [cube + 1, row - 1, column],
        [cube + 1, row - 1, column + 1],
        [cube + 1, row, column - 1],
        [cube + 1, row, column],
        [cube + 1, row, column + 1],
        [cube + 1, row + 1, column - 1],
        [cube + 1, row + 1, column],
        [cube + 1, row + 1, column + 1],
    ]
end


def calculate_new_value(current_value, active_count)
    return INACTIVE if current_value == ACTIVE and ![2,3].include? active_count
    return ACTIVE if current_value == INACTIVE and active_count == 3
    current_value
end


def get_updates(cubes)
    cubes.map do |key, value|
        neighbours = get_neighbours(*key).map {|k| cubes[k]}
        active = neighbours.filter {|v| v == ACTIVE}
        new_value = calculate_new_value(cubes[key], active.count)
        p key if new_value == ACTIVE
        [key, new_value]
    end.to_h
end

def one
    cubes = Hash.new(INACTIVE)
    cubes.merge! ((-6..6).map { |c| (-7..12).map {|r| (-7..12).map {|c| [r, c] }}.flatten(1).map {|v| [c, *v]} }.flatten(1).map {|place| [place, INACTIVE]}.to_h)
    File.read(INPUT_FILE).lines.map(&:strip).each_with_index.map do |line, row|
        line.split("").each_with_index.each { |value, column| cubes[[0, row, column]] = value }
    end
    
    (0..5).each do |i|
        cubes = get_updates(cubes)
    end
    cubes.values.filter{|v| v== ACTIVE}.count
end


def two
end

p one
#p two 

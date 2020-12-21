require 'set'

ACTIVE = "#"
INACTIVE = "."
INPUT_FILE = "input_17.txt"



def get_neighbours(hyper, cube, row, column)
    v = []
    ((hyper-1)..(hyper+1)).each do |h|
        ((cube-1)..(cube+1)).each do |cu|
            ((row-1)..(row+1)).each do |r|
                ((column-1)..(column+1)).each do |c|
                    v << [h, cu, r, c] unless [h, cu, r, c] == [hyper, cube, row, column]
                end
            end
        end
    end
    v
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
        [key, new_value]
    end.to_h
end


def gen_cubes()
    (-6..6).map { |h|
        (-6..6).map { |cube| (-7..12).map {|r| (-7..12).map {|c| [[h,cube,r,c], INACTIVE]} }.flatten(1) }.flatten(1)
    }.flatten(1).to_h
end

def two
    hypercubes = Hash.new(INACTIVE)
    hypercubes.merge! gen_cubes
    File.read(INPUT_FILE).lines.map(&:strip).each_with_index.map do |line, row|
        line.split("").each_with_index.each { |value, column| hypercubes[[0, 0, row, column]] = value }
    end
    (0..5).each do |i|
        hypercubes = get_updates(hypercubes)
    end
    hypercubes.values.filter{|v| v== ACTIVE}.count
end


p two

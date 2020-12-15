require_relative 'day12_1'
require_relative 'day12_2'

FILE_INPUT = "input_12.txt"

def handle_instructions(instruction)
  File.read(FILE_INPUT).lines.map { |coord| coord.strip.match(/(\w)(\d+)/).captures }.each do |direction, steps|
    steps = steps.to_i
    case direction
    when "N"
      instruction.move_north(steps)
    when "S"
      instruction.move_south(steps)
    when "W"
      instruction.move_west(steps)
    when "E"
      instruction.move_east(steps)
    when "F"
      instruction.move_forward(steps)
    when "L"
      instruction.move_left(steps)
    when "R"
      instruction.move_right(steps)
    else
      p direction
    end
  end
  instruction.manhattan_distance
end

def one
  # 1601
  handle_instructions(Coordinates.new)
end

def two
  # 13340
  handle_instructions(WaypointCoordinates.new)
end

p one
p two

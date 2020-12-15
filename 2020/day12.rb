FILE_INPUT = "input_12.txt"

REGEX = /(\w)(\d+)/

class Coordinates
  attr_reader :north, :east, :current_direction

  def initialize
    @north = 0
    @east = 0
    @current_direction = "E"
  end

  def move_north(steps)
    @north += steps
  end

  def move_south(steps)
    @north -= steps
  end

  def move_east(steps)
    @east += steps
  end

  def move_west(steps)
    @east -= steps
  end

  def move_forward(steps)
    @east += steps if @current_direction == "E"
    @east -= steps if @current_direction == "W"
    @north += steps if @current_direction == "N"
    @north -= steps if @current_direction == "S"
  end

  def move_left(degrees)
    times = degrees / 90
    changes = {
      "N" => "W",
      "W" => "S",
      "S" => "E",
      "E" => "N"
    }
    while times > 0
      @current_direction = changes[@current_direction]
      times -= 1
    end
  end

  def move_right(degrees)
    times = degrees / 90
    changes = {
      "N" => "E",
      "E" => "S",
      "S" => "W",
      "W" => "N"
    }
    while times > 0
      @current_direction = changes[@current_direction]
      times -= 1
    end
  end

  def manhattan_distance
    @north.abs + @east.abs
  end
end

def one
  instruction = Coordinates.new
  File.read(FILE_INPUT).lines.map { |coord| coord.strip.match(REGEX).captures }.each do |direction, steps|
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

p one

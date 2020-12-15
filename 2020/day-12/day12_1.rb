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

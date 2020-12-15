class WaypointCoordinates
  attr_reader :north, :east, :waypoint_east, :waypoint_north

  def initialize
    @north = 0
    @east = 0
    @waypoint_east = 10
    @waypoint_north = 1
  end

  def move_north(steps)
    @waypoint_north += steps
  end

  def move_south(steps)
    @waypoint_north -= steps
  end

  def move_east(steps)
    @waypoint_east += steps
  end

  def move_west(steps)
    @waypoint_east -= steps
  end

  def move_forward(steps)
    @east += steps * @waypoint_east
    @north += steps * @waypoint_north
  end

  def move_left(degrees)
    wn = @waypoint_north
    we = @waypoint_east
    case degrees / 90
    when 1
      @waypoint_north = we
      @waypoint_east = -1 * wn
    when 2
      @waypoint_east *= -1
      @waypoint_north *= -1
    when 3
      @waypoint_north = -1 * we
      @waypoint_east = wn
    end
  end

  def move_right(degrees)
    wn = @waypoint_north
    we = @waypoint_east
    case degrees / 90
    when 1
      @waypoint_north = we * -1
      @waypoint_east = wn
    when 2
      @waypoint_east *= -1
      @waypoint_north *= -1
    when 3
      @waypoint_north = we
      @waypoint_east = -1 * wn
    end
  end

  def manhattan_distance
    @north.abs + @east.abs
  end
end

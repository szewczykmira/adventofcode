INPUT_FILE = "input_11.txt"

FLOOR = "."
EMPTY_SEAT = "L"
TAKEN_SEAT = "#"

def get_neighbour(waiting_room, row, column)
  [
    [row - 1, column - 1],
    [row - 1, column],
    [row - 1, column + 1],
    [row, column - 1],
    [row, column + 1],
    [row + 1, column - 1],
    [row + 1, column],
    [row + 1, column + 1],
  ].filter { |r, c| r >= 0 and c >= 0 and r < waiting_room.count and c < waiting_room[0].count }
    .map { |r, c| waiting_room[r][c] }
end

def validate_empty(neighbours, field)
  return false unless field == EMPTY_SEAT

  neighbours.filter { |value| value == TAKEN_SEAT }.count == 0
end

def validate_taken(neighbours, field)
  return false unless field == TAKEN_SEAT

  neighbours.filter { |value| value == TAKEN_SEAT }.count >= 4
end

def exchange_seats(waiting_room)
  new_seats = []
  waiting_room.each_with_index do |row, index_row|
    new_row = []
    row.each_with_index do |field, index_column|
      neighbours = get_neighbour(waiting_room, index_row, index_column)
      expected_value = field
      expected_value = TAKEN_SEAT if validate_empty(neighbours, field)
      expected_value = EMPTY_SEAT if validate_taken(neighbours, field)
      new_row << expected_value
    end
    new_seats << new_row
  end
  new_seats
end

def one
  waiting_room = File.read(INPUT_FILE).lines.map { |x| x.strip.split("") }
  change_count = 0
  while true
    new_waiting_room = exchange_seats(waiting_room)
    does_changed = waiting_room != new_waiting_room
    change_count += 1 if does_changed
    break if not does_changed

    waiting_room = new_waiting_room
  end
  waiting_room.map { |row| row.filter { |field| field == TAKEN_SEAT }.count }.reduce(:+)
end

def get_neighbour_for_two(waiting_room, row, column)
  # up
  check_out_row = row - 1
  up = nil
  while check_out_row >= 0 do
    value = waiting_room[check_out_row][column]
    up = value
    break if value != FLOOR

    check_out_row -= 1
  end
  # down
  check_out_row = row + 1
  down = nil
  while check_out_row < waiting_room.count do
    value = waiting_room[check_out_row][column]
    down = value
    break if value != FLOOR

    check_out_row += 1
  end
  # left
  check_out_column = column - 1
  left = nil
  while check_out_column >= 0 do
    value = waiting_room[row][check_out_column]
    left = value
    break if value != FLOOR

    check_out_column -= 1
  end
  # right
  check_out_column = column + 1
  right = nil
  while check_out_column < waiting_room[0].count do
    value = waiting_room[row][check_out_column]
    right = value
    break if value != FLOOR

    check_out_column += 1
  end

  # up, left
  check_out_row = row - 1
  check_out_column = column - 1
  up_left = nil
  while check_out_row >= 0 and check_out_column >= 0 do
    value = waiting_room[check_out_row][check_out_column]
    up_left = value
    break if value != FLOOR

    check_out_row -= 1
    check_out_column -= 1
  end
  # down, left
  check_out_row = row + 1
  check_out_column = column - 1
  down_left = nil
  while check_out_row < waiting_room.count and check_out_column >= 0 do
    value = waiting_room[check_out_row][check_out_column]
    down_left = value
    break if value != FLOOR

    check_out_row += 1
    check_out_column -= 1
  end
  # up, right
  check_out_row = row - 1
  check_out_column = column + 1
  up_right = nil
  while check_out_row >= 0 and check_out_column < waiting_room[0].count do
    value = waiting_room[check_out_row][check_out_column]
    up_right = value
    break if value != FLOOR

    check_out_row -= 1
    check_out_column += 1
  end
  # down,right
  check_out_row = row + 1
  check_out_column = column + 1
  down_right = nil
  while check_out_row < waiting_room.count and check_out_column < waiting_room[0].count do
    value = waiting_room[check_out_row][check_out_column]
    down_right = value
    break if value != FLOOR

    check_out_row += 1
    check_out_column += 1
  end
  [up, down, left, right, up_left, up_right, down_left, down_right].filter { |o| !o.nil? }
end

def validate_taken_two(neighbours, field)
  return false unless field == TAKEN_SEAT

  neighbours.filter { |value| value == TAKEN_SEAT }.count >= 5
end

def exchange_seats_two(waiting_room)
  new_seats = []
  waiting_room.each_with_index do |row, index_row|
    new_row = []
    row.each_with_index do |field, index_column|
      neighbours = get_neighbour_for_two(waiting_room, index_row, index_column)
      expected_value = field
      expected_value = TAKEN_SEAT if validate_empty(neighbours, field)
      expected_value = EMPTY_SEAT if validate_taken_two(neighbours, field)
      new_row << expected_value
    end
    new_seats << new_row
  end
  new_seats
end

def two
  waiting_room = File.read(INPUT_FILE).lines.map { |x| x.strip.split("") }
  change_count = 0
  while true
    new_waiting_room = exchange_seats_two(waiting_room)
    does_changed = waiting_room != new_waiting_room
    change_count += 1 if does_changed
    break if not does_changed

    waiting_room = new_waiting_room
  end
  waiting_room.map { |row| row.filter { |field| field == TAKEN_SEAT }.count }.reduce(:+)
end

p one
p two

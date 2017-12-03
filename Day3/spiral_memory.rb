include Math

# if the side is even its square is in 00
# if square is odd square is in (side-1), (side-1)

def find_center(side)
  position = side / 2
  position = position - 1 if side.even?
  [position, position]
end

def position_even(elem, side)
  previous_square = (side - 1) * (side-1)
  sides_difference = (side*side) - previous_square
  position = elem - previous_square
  half = sides_difference / 2
  if position == (half+1)
    return [0, side -1]
  end
  if position <= half
    return [side - position , side - 1]
  end
  [0, (side*side) - elem]
end

def position_odd(elem, side)
  previous_square = (side - 1) * (side-1)
  sides_difference = (side*side) - previous_square
  position = elem - previous_square
  half = sides_difference / 2
  if position == (half+1)
    return [side - 1, 0]
  end
  if position <= half
    return [position - 1, 0]
  end
  [side - 1, position - side]
end

def find_position(elem, side)
  side.even? ? position_even(elem, side) : position_odd(elem, side)
end

def spiral_memory(elem)
  side = sqrt(elem).ceil
  center_row, center_cell = find_center(side)
  elem_row, elem_cell = find_position(elem, side)
  (center_row - elem_row).abs + (center_cell - elem_cell).abs
end

def test
  raise unless spiral_memory(1) == 0
  raise unless spiral_memory(12) == 3
  raise unless spiral_memory(23) == 2
  raise unless spiral_memory(1024) == 31
end

def test_center
  raise unless find_center(1) == [0, 0]
  raise unless find_center(2) == [0, 0]
  raise unless find_center(3) == [1, 1]
  raise unless find_center(4) == [1, 1]
  raise unless find_center(5) == [2, 2]
end

def test_position
  (print find_position(31, 6); raise) unless find_position(31, 6) == [0, 5]
  (print find_position(35, 6); raise) unless find_position(35, 6) == [0, 1]
  (print find_position(28, 6); raise) unless find_position(28, 6) == [3, 5]
  (print find_position(43, 7); raise) unless find_position(43, 7) == [6, 0]
  (print find_position(40, 7); raise) unless find_position(40, 7) == [3, 0]
  (print find_position(47, 7); raise) unless find_position(47, 7) == [6, 4]

  (print find_position(15, 4); raise) unless find_position(15, 4) == [0, 1]
  (print find_position(13, 4); raise) unless find_position(13, 4) == [0, 3]
  (print find_position(11, 4); raise) unless find_position(11, 4) == [2, 3]
  (print find_position(20, 5); raise) unless find_position(20, 5) == [3, 0]
  (print find_position(21, 5); raise) unless find_position(21, 5) == [4, 0]
  (print find_position(23, 5); raise) unless find_position(23, 5) == [4, 2]
end

test_center
test_position
puts spiral_memory(1)
puts spiral_memory(12)
puts spiral_memory(23)
puts spiral_memory(1024)
puts spiral_memory(368078)

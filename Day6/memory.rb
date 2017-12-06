def redistribute(old_blocks)
  blocks = old_blocks.clone
  length = blocks.length
  to_distribute = blocks.max
  index = blocks.find_index to_distribute
  blocks[index] = 0
  current = (index + 1) % length
  while to_distribute > 0 do
    blocks[current] += 1
    to_distribute -= 1
    current = (current + 1) % length
  end
  blocks
end


def walk(blocks)
  steps = 0
  compilations = []
  current_blocks = blocks
  while not (compilations.include? current_blocks)
    compilations.push current_blocks
    current_blocks = redistribute(current_blocks)
    steps += 1
  end
  steps
end


def test_redistribute
  raise unless redistribute([0, 2, 7, 0]) == [2,4,1,2]
  raise unless redistribute([2,4,1,2]) == [3,1,2,3]
  raise unless redistribute([3,1,2,3]) == [0, 2, 3, 4]
  raise unless redistribute([0,2,3,4]) == [1,3,4,1]
  raise unless redistribute([1,3,4,1]) == [2,4,1,2]
end

puts walk([0,2,7,0])
puts walk [5, 1, 10, 0, 1, 7, 13, 14, 3, 12, 8, 10, 7, 12, 0, 6]

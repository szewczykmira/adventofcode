def part1(offset_list=nil)
  unless offset_list
    offset_list = File.open('input.txt').map {|step| step.to_i}
  end
  current_elem = 0
  counter_step = 0
  while current_elem < offset_list.length do
    jump = offset_list[current_elem]
    offset_list[current_elem] += 1
    counter_step += 1
    current_elem += jump
  end
  counter_step
end

def part2
  offset_list = File.open('input.txt').map {|step| step.to_i}
  current_elem = 0
  counter_step = 0
  while current_elem < offset_list.length do
    jump = offset_list[current_elem]
    offset_list[current_elem] += (jump < 3 ? 1 : -1)
    counter_step += 1
    current_elem += jump
  end
  counter_step
end

def test
  raise unless part1([0,3, 0, 1, -3]) == 5
end

puts part2

def compute(list, seq, curr_position, skip_size, last)
  if last < list.length
    list[curr_position, last] = list[curr_position, last].reverse
  else
    buffer_front = last - list.length
    data = list[curr_position, list.length] + list[0, buffer_front]
    data = data.reverse

    buffer_back = list.length - curr_position
    list[curr_position, list.length] = data[0, list.length - curr_position-1]
    list[0, buffer_front] = data[buffer_back-1, data.length]
  end
end

def generate_hash(sequence)
  list = (0..255).to_a
  #list = [0,1,2,3,4]
  curr_position = 0
  skip_size = 0
  sequence.each do |seq|
    last = curr_position + seq
    if seq > 1
      compute(list, seq, curr_position, skip_size, last)
    end
    curr_position = (last + skip_size) % list.length
    skip_size += 1
  end
  list
end


print generate_hash([94,84,0,79,2,27,81,1,123,93,218,23,103,255,254,243])
#print generate_hash([3,4,1,5])

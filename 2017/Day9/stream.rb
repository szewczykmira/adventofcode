GROUP_BEGIN = '{'
GROUP_END = '}'

GARBAGE_BEGIN = '<'
GARBAGE_END = '>'
GARBAGE_CANCEL = '!'

def get_proper(stream)
  deleted = 0
  groups = []
  stream = stream.chars
  garbage_open = false
  stream.each_index do |index|
    if stream[index] == GARBAGE_CANCEL
      stream[index+1] = nil
      next
    end
    if garbage_open and stream[index] == GARBAGE_END
      garbage_open = false
      next
    end
    if garbage_open
      if stream[index]
        deleted += 1
      end
      next
    end
    if stream[index] == GARBAGE_BEGIN
      garbage_open = true
      next
    end
    groups.push(stream[index])
  end
  puts deleted
  groups
end

def walk_groups(stream)
  groups = get_proper stream
  score = 1
  scores = []
  groups.each do |g|
    next if g == ','
    if g == GROUP_BEGIN
      scores.push(score)
      score += 1
    else
      score -= 1
    end
  end
  scores.inject(0){|sum,x| sum + x }
end

data = File.read('input.txt').strip
print walk_groups data

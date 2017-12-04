require 'set'

def Counter(elem)
  counter = Hash.new(0)
  elem.chars.each {|c| counter[c] += 1 }
  counter
end

def is_valid?(pass)
  splitted = pass.split
  counters = splitted.map {|elem| Counter(elem)}
  counters.length == counters.to_set.length
end

def main
  valid = File.open('input.txt').map {|line| is_valid?(line) ? 1 : 0}
  valid.inject(0) {|sum, x| sum+= x}
end


def test_is_valid_anagrams
  raise unless is_valid? "abcde fghij"
  raise unless not is_valid? "abcde xyz ecdab"
  raise unless is_valid? "a ab abc abd abf abj"
  raise unless is_valid? "iiii oiii ooii oooi oooo"
  raise unless not is_valid? "oiii ioii iioi iiio is not valid"
end

puts main

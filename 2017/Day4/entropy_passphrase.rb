require 'set'

def is_valid?(phrase)
  splitted = phrase.split
  splitted.length == splitted.to_set.length
end

def main
  valid = File.open('input.txt').map {|line| is_valid?(line) ? 1 : 0}
  valid.inject(0) {|sum, x| sum+= x}
end

def test_is_valid
  raise unless is_valid? "aa bb cc dd ee"
  raise unless not is_valid? "aa bb cc dd aa"
  raise unless is_valid? "aa bb cc dd aaa"
end

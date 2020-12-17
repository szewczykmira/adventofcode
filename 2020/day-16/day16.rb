require 'set'
INPUT = "input_16.txt"

def in_rules(rules, number)
  rules.values.each do |rule|
    return false if rule.include? number
  end
  true
end

def gen_possibilites(ticket, rules)
  options = []
  ticket.each do |number|
    number_options = []
    rules.each do |name, values|
      number_options << name if values.include? number
    end
    return [] if number_options.count == 0

    options << number_options
  end
  return options
end

def gen_rules(data)
  data.split("\n").map { |line| line.match(/^([\w\s]+): (\d+)-(\d+) or (\d+)-(\d+)$/) }.map do |match|
    name, *info = match.captures
    start1, end1, start2, end2 = info.map(&:to_i)
    [name, (start1..end1).to_a.concat((start2..end2).to_a)]
  end.to_h
end

def one
  lines = File.read(INPUT)
  first_part, rest = lines.split("\n\nyour ticket:\n")
  rules = gen_rules(first_part)
  _, neighbours = rest.split("\n\nnearby tickets:\n")
  failed = []
  neighbours.split("\n").map { |line| line.split(",").map(&:to_i) }.each do |ticket|
    failed.concat (ticket.filter { |number| in_rules(rules, number) })
  end
  failed.reduce(:+)
end

def calculate_choices(options)
  choices = [[]]
  options.each do |option|
    option.each do |rule|
      choices.each do |choice|
        choices << (choice.dup << rule) unless choice.include? rule
      end
    end
  end
  choices
end

def two
  lines = File.read(INPUT)
  first_part, rest = lines.split("\n\nyour ticket:\n")
  rules = gen_rules(first_part)
  ticket, neighbours = rest.split("\n\nnearby tickets:\n")
  my_ticket = ticket.split(",").map(&:to_i)
  available_options = [rules.keys.to_set] * my_ticket.count
  neighbours.split("\n").map { |line| line.split(",").map(&:to_i) }.each do |ticket|
    options = []
    ticket.each_with_index do |number, index|
      number_options = available_options[index].filter { |rule| rules[rule].include? number }.to_set
      options << number_options
    end
    next if options.filter { |o| o.count == 0 }.count > 0

    available_options.zip(options).each_with_index do |zip, i|
      a, o = zip
      available_options[i] = (a.intersection o)
    end
  end
  already_calculated = []
  prev_count = 0
  while available_options.filter { |set| set.count == 1 }.count != prev_count
    only_one = available_options.filter { |set| set.count == 1 }.map { |ob| ob.to_a[0] }.filter { |el| !already_calculated.include? el }[0]
    prev_count = available_options.filter { |set| set.count == 1 }.count
    available_options.map do |option|
      option.delete only_one if option.count > 1
    end
    already_calculated << only_one
  end
  available_options.map { |obj| obj.to_a[0] }.zip(my_ticket).filter { |rule, number| rule.start_with? "departure" }.map { |x| x[1] }.reduce(:*)
end

p one
p two

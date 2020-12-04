require 'set'
REQUIRED_FIELDS = Set["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

def are_all(value)
  value.split.map { |x| x.split(":").first }.to_set.superset? REQUIRED_FIELDS
end

def one
  File.read("input_4_1.txt").split("\n\n").select { |obj| are_all obj }.count
end

def validate_height(value)
  return ((150..193).include? value[0..-2].to_i) if value.end_with? "cm"

  return ((59..76).include? value[0..-2].to_i) if value.end_with? "in"

  false
end

def full_validation(value)
  passport = value.split.map { |x| x.split(":") }.to_h
  [
    ((1920..2002).include? passport["byr"].to_i),
    ((2010..2020).include? passport["iyr"].to_i),
    ((2020..2030).include? passport["eyr"].to_i),
    validate_height(passport["hgt"]),
    (not passport["hcl"].match(/#[a-f0-9]{6}$/).nil?),
    # WTF?!
    (%w(amb blu brn gry grn hzl oth).include? passport["ecl"]),
    passport["pid"].match(/^\d{9}$/)
  ].all?
end

def two
  File.read("input_4_2.txt").split("\n\n").select { |obj| (are_all obj) and (full_validation obj) }.count
end

p one
p two

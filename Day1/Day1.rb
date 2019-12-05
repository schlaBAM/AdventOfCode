
# DAY 1 Advent of code
#
file = File.read("input.txt").split
# Part 1
file.each do |x|
  sum += ((x.to_i / 3).floor) - 2
end

puts sum

# Part 2

def get_fuel(fuel)
  num = ((fuel / 3).floor) - 2
  return 0 if num <= 0
  num + get_fuel(num)
end

sum = 0

file.each do |x|
  sum += get_fuel(x.to_i)
end

puts sum
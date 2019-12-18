# Carrying on from part 1:
#
# It turns out that this circuit is very timing-sensitive; you actually need to minimize the signal delay.
#
# To do this, calculate the number of steps each wire takes to reach each intersection; choose the intersection where
# the sum of both wires' steps is lowest. If a wire visits a position on the grid multiple times, use the steps value
# from the first time it visits that position when calculating the total value of a specific intersection.

#def check_min(x1, y1, x2, y2, dist)
#  if x1 + y1 < dist
#    dist = x1 + y1
#  end
#  dist
#end

def generate_hash(wire)

  results = Hash.new(0)
  count = 1
  wire1x = 0
  wire1y = 0

  wire.each do |x|
    direction = x[0]
    distance = x[1..-1].to_i
    case direction
    when 'D'
      (1..distance).each do |i|
        wire1y -= 1
        unless results.has_key? [wire1x, wire1y]
          results[[wire1x, wire1y]] = count
        end
        count += 1
      end
    when 'U'
      (1..distance).each do |i|
        wire1y += 1
        unless results.has_key? [wire1x, wire1y]
          results[[wire1x, wire1y]] = count
        end
        count += 1
      end
    when 'L'
      (1..distance).each do |i|
        wire1x -= 1
        unless results.has_key? [wire1x, wire1y]
          results[[wire1x, wire1y]] = count
        end
        count += 1
      end
    when 'R'
      (1..distance).each do |i|
        wire1x += 1
        unless results.has_key? [wire1x, wire1y]
          results[[wire1x, wire1y]] = count
        end
        count += 1
      end
    end
  end
  results
end

def remove_extras(hash1, hash2)
  hash1.delete_if{ |x| !hash2.has_key?(x)}
end

max_distance = 1000000

wires = File.read("input3.txt").split(" ")

wire1 = wires[0].split(",")
wire2 = wires[1].split(",")

locations1 = generate_hash(wire1)
locations2 = generate_hash(wire2)

#intersections1 = remove_extras(locations1, locations2)
#intersections2 = remove_extras(locations2, locations1)
#
sums = Array.new

locations1.keys.each do |x|
  if locations2.has_key?(x)
    steps = locations1[x] + locations2[x]
    sums.push(steps)
    #puts steps
    #puts
    #if steps <= max_distance
    #  print x
    #  puts
    #  puts locations1[x]
    #  puts locations2[x]
    #  puts
    #  max_distance = steps
    #
    #end
  end
end

print sums.sort

  #check_min(x[0].abs, x[1].abs, max_distance, closest_distance) }.min

#closest_distance1 = locations2.keys.each { |x| check_min(x[0].abs, x[1].abs, max_distance, closest_distance1) }.min

#puts max_distance

# 43307 - too high.
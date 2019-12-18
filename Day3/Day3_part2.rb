# Carrying on from part 1:
#
# It turns out that this circuit is very timing-sensitive; you actually need to minimize the signal delay.
#
# To do this, calculate the number of steps each wire takes to reach each intersection; choose the intersection where
# the sum of both wires' steps is lowest. If a wire visits a position on the grid multiple times, use the steps value
# from the first time it visits that position when calculating the total value of a specific intersection.

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

wires = File.read("input3.txt").split(" ")

wire1 = wires[0].split(",")
wire2 = wires[1].split(",")

locations1 = generate_hash(wire1)
locations2 = generate_hash(wire2)
sums = Array.new(0)

locations1.keys.each do |x|
  if locations2.has_key?(x)
    sums.push(locations1[x] + locations2[x])
  end
end

puts "Shortest path to intersection from both wires: #{sums.sort[0]}"




# ALTERNATE WAY - (also using some of above)
#
# def find_intersection(wire1, hash)
#
#  results = Hash.new(0)
#  count = 1
#  wire1x = 0
#  wire1y = 0
#
#  wire1.each do |x|
#    direction = x[0]
#    distance = x[1..-1].to_i
#    case direction
#    when 'D'
#      (1..distance).each do |i|
#        wire1y -= 1
#        if hash.has_key?([wire1x, wire1y]) && !results.has_key?([wire1x, wire1y])
#          results[[wire1x, wire1y]] = count
#        end
#        count += 1
#      end
#    when 'U'
#      (1..distance).each do |i|
#        wire1y += 1
#        if hash.has_key?([wire1x, wire1y]) && !results.has_key?([wire1x, wire1y])
#          results[[wire1x, wire1y]] = count
#        end
#        count += 1
#      end
#    when 'L'
#      (1..distance).each do |i|
#        wire1x -= 1
#        if hash.has_key?([wire1x, wire1y]) && !results.has_key?([wire1x, wire1y])
#          results[[wire1x, wire1y]] = count
#        end
#        count += 1
#      end
#    when 'R'
#      (1..distance).each do |i|
#        wire1x += 1
#        if hash.has_key?([wire1x, wire1y]) && !results.has_key?([wire1x, wire1y])
#          results[[wire1x, wire1y]] = count
#        end
#        count += 1
#      end
#    end
#  end
#  results
#end


#intersections = find_intersection(wire2, locations1)
#
#intersections.each_key do |k|
#  intersections[k] = intersections[k] + locations1[k]
#end
#
#print intersections.values.sort[0]
#

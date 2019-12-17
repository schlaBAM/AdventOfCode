# say central port starts at 0,0

# 2 wires, find closest intersection (manhattan distance) to central port.
# First character in command is direction (U, D, L, R)

# logic:
# grab first character from each position in array to find direction
# left = -x. right = +x
# down = -y, up = +y

closest_distance = 100000

wires = File.read("input3.txt").split(" ")

wire1 = wires[0].split(",")
wire2 = wires[1].split(",")

def check_max(x1, y1, dist)
  if x1 + y1 < dist
    dist = x1 + y1
  end
  dist
end

def generate_array(wire)

  results = Array.new
  wire1x = 0
  wire1y = 0

  wire.each do |x|
    direction = x[0]
    distance = x[1..-1].to_i
    case direction
    when 'D'
      (0..distance).each do |i|
        wire1y -= 1
        results.push([wire1x, wire1y])
      end
    when 'U'
      (0..distance).each do |i|
        wire1y += 1
        results.push([wire1x, wire1y])
      end
    when 'L'
      (0..distance).each do |i|
        wire1x -= 1
        results.push([wire1x, wire1y])
      end
    when 'R'
      (0..distance).each do |i|
        wire1x += 1
        results.push([wire1x, wire1y])
      end
    end
  end
  results.uniq
end


locations1 = generate_array(wire1).map {|x| [x,true]}.to_h
locations2 = generate_array(wire2).map {|x| [x,true]}.to_h

intersections = locations1.delete_if{ |x| !locations2.has_key?(x)}

intersections.keys.each do |x,y|
  closest_distance = check_max(x.abs,y.abs,closest_distance)
end

puts closest_distance





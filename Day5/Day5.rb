# 3 or 4, +2
# size = 4 or maybe also 5, +1
# else +4 ?

#only input for 3 == 1 (for our tests)
#
#
# get opcode, get size
# case statement on size

def position_mode(input, position)
  input[input[position]]
end

def immediate_mode(input, position)
  input[position]
end

def get_code_value(input)

  position = 0

  while position < input.size

    num = input[position].to_s

    while num.length < 4
      num = '0' + num
    end

    opcode = num.chars.last(2).join.to_i
    num = num[0,2].reverse #have parameter modes in order

    case opcode
    when 1
      #addition
      result = 0
      curr_position = 1
      num.chars.each do |x|
        if x.to_i == 0
          result += position_mode(input, position + curr_position)
        else
          result += immediate_mode(input, position + curr_position)
        end
        curr_position += 1
      end
      input[input[position + 3]] = result
      position += 4
    when 2
      #multiplication
      result = 1
      curr_position = 1
      num.chars.each do |x|
        if x.to_i == 0
          result *= position_mode(input, position + curr_position)
        else
          result *= immediate_mode(input, position + curr_position)
        end
        curr_position += 1
      end
      input[input[position + 3]] = result
      position += 4
    when 3
      input[input[position + 1]] = 1
      position += 2
    when 4
      if num[0].to_i == 1
        #immediate mode
        puts "Output: #{input[position + 1]}"
      else
        #position mode
        puts "Output: #{input[input[position + 1]]}"
      end
      position += 2
    when 99
      #program immediately halts
      break
    else
      #should never be hit
      puts opcode
      puts "ya blew it. invalid opcode"
      break
    end
  end
end

get_code_value(File.read("input5.txt").split(",").map(&:to_i))
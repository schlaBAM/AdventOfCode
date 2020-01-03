# Day 5 Complete

def get_code_value(input)

  position = 0

  while position < input.size

    num = input[position].to_s

    while num.length < 4
      num = '0' + num
    end

    opcode = num.chars.last(2).join.to_i
    num = num[0, 2].reverse #have parameter modes in order
    mode_one = num[0].to_i
    mode_two = num[1].to_i

    case opcode
    when 1
      #addition
      result = ((mode_one == 0 ? position_mode(input, position + 1) : immediate_mode(input, position + 1)) + (mode_two == 0 ? position_mode(input, position + 2) : immediate_mode(input, position + 2)))
      input[input[position + 3]] = result
      position += 4
    when 2
      #multiplication
      result = ((mode_one == 0 ? position_mode(input, position + 1) : immediate_mode(input, position + 1)) * (mode_two == 0 ? position_mode(input, position + 2) : immediate_mode(input, position + 2)))
      input[input[position + 3]] = result
      position += 4
    when 3
      #input value at position
      input[input[position + 1]] = INPUT_VALUE
      position += 2
    when 4
      #output value at position
      if mode_one == 0
        #position mode
        puts "Output: #{position_mode(input, position + 1)}"
      else
        #immediate mode
        puts "Output: #{immediate_mode(input, position + 1)}"
      end
      position += 2
    when 5
      #Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
      parameter1 = mode_one == 0 ? position_mode(input, position + 1) : immediate_mode(input, position + 1)
      if parameter1 != 0
        if mode_two == 0
          position = position_mode(input, position + 2)
        else
          position = immediate_mode(input, position + 2)
        end
      else
        position += 3
      end
    when 6
      #Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value from the second parameter. Otherwise, it does nothing.
      parameter1 = mode_one == 0 ? position_mode(input, position + 1) : immediate_mode(input, position + 1)
      if parameter1 == 0
        if mode_two == 0
          position = position_mode(input, position + 2)
        else
          position = immediate_mode(input, position + 2)
        end
      else
        position += 3
      end
    when 7
      #Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
      parameter1 = mode_one == 0 ? position_mode(input, position + 1) : immediate_mode(input, position + 1)
      parameter2 = mode_two == 0 ? position_mode(input, position + 2) : immediate_mode(input, position + 2)
      if parameter1 < parameter2
        input[input[position + 3]] = 1
      else
        input[input[position + 3]] = 0
      end
      position += 4
    when 8
      #Opcode 8 is equals: if the first parameter is equal to the second parameter, it stores 1 in the position given by the third parameter. Otherwise, it stores 0.
      parameter1 = mode_one == 0 ? position_mode(input, position + 1) : immediate_mode(input, position + 1)
      parameter2 = mode_two == 0 ? position_mode(input, position + 2) : immediate_mode(input, position + 2)
      if parameter1 == parameter2
        input[input[position + 3]] = 1
      else
        input[input[position + 3]] = 0
      end
      position += 4
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

def position_mode(input, position)
  input[input[position]]
end

def immediate_mode(input, position)
  input[position]
end

INPUT_VALUE = 5
get_code_value(File.read("input5.txt").split(",").map(&:to_i))

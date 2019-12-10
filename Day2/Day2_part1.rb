
# Day 2 - Advent of Code
#
# An Intcode program is a list of integers separated by commas (like 1,0,0,3,99). To run one, start by looking at the
# first integer (called position 0). Here, you will find an opcode - either 1, 2, or 99. The opcode indicates what to
# do; for example, 99 means that the program is finished and should immediately halt. Encountering an unknown opcode
# means something went wrong.
#
# Opcode 1 adds together numbers read from two positions and stores the result in a third position. The three integers
# immediately after the opcode tell you these three positions - the first two indicate the positions from which you
# should read the input values, and the third indicates the position at which the output should be stored.
#
# For example, if your Intcode computer encounters 1,10,20,30, it should read the values at positions 10 and 20, add
# those values, and then overwrite the value at position 30 with their sum.
#
# Opcode 2 works exactly like opcode 1, except it multiplies the two inputs instead of adding them. Again, the three
# integers after the opcode indicate where the inputs and outputs are, not their values.
#
# Once you're done processing an opcode, move to the next one by stepping forward 4 positions.
#
# Once you have a working computer, the first step is to restore the gravity assist program (your puzzle input) to
# the "1202 program alarm" state it had just before the last computer caught fire. To do this, before running the
# program, replace position 1 with the value 12 and replace position 2 with the value 2. What value is left at
# position 0 after the program halts?

def get_code_value(input)

  position = 0

  while position < input.size

    case input[position]
    when 1
      #addition
      input[input[position + 3]] = input[input[position + 1]] + input[input[position + 2]]
    when 2
      #multiplication
      input[input[position + 3]] = input[input[position + 1]] * input[input[position + 2]]
    when 99
      #program immediately halts
      break
    else
      #should never be hit
      puts "ya blew it. invalid opcode"
      break
    end

    position += 4
  end

  input[0]

end

file = File.read("input2.txt").split(",").map(&:to_i)

file[1] = 12
file[2] = 2

puts get_code_value(file) # returns 3562624
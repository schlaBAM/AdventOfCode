
# Advent of Code Day 2 - Part 2
# --- Part Two ---
#
# Opcodes (like 1, 2, or 99) mark the beginning of an instruction. The values used immediately
# after an opcode, if any, are called the instruction's parameters. For example, in the instruction
# 1,2,3,4, 1 is the opcode; 2, 3, and 4 are the parameters. The instruction 99 contains only an opcode
# and has no parameters.
#
# The address of the current instruction is called the instruction pointer; it starts at 0. After an
# instruction finishes, the instruction pointer increases by the number of values in the instruction;
# until you add more instructions to the computer, this is always 4 (1 opcode + 3 parameters) for the
# add and multiply instructions. (The halt instruction would increase the instruction pointer by 1,
# but it halts the program instead.)
#
# "With terminology out of the way, we're ready to proceed. To complete the gravity assist, you need
# to determine what pair of inputs produces the output 19690720."
#
# The inputs should still be provided to the program by replacing the values at addresses 1 and 2, just
# like before. In this program, the value placed in address 1 is called the noun, and the value placed
# in address 2 is called the verb. Each of the two input values will be between 0 and 99, inclusive.
#
# Once the program has halted, its output is available at address 0, also just like before. Each time
# you try a pair of inputs, make sure you first reset the computer's memory to the values in the program
# (your puzzle input) - in other words, don't reuse memory from a previous attempt.
#
# Find the input noun and verb that cause the program to produce the output 19690720.
# What is 100 * noun + verb? (For example, if noun=12 and verb=2, the answer would be 1202.)

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

  input

end

def find_pair (input, output)
  for noun in 0...99 do
    for verb in 0...99 do
      test_file = input.clone
      test_file[1] = noun
      test_file[2] = verb

      if get_code_value(test_file)[0] == output
        return [noun, verb]
      end
    end
  end
  ["pair was", "not found"]
end

file = File.read("input2.txt").split(",").map(&:to_i)

output = 19690720
result = find_pair(file, output)

if !result[0].is_a?(String)
  puts 100 * result[0] + result[1]
else
  puts "Pair not found"
end





# --- Day 4: Secure Container ---
#You arrive at the Venus fuel depot only to discover it's protected by a password. The Elves had written the password
# on a sticky note, but someone threw it out.
#
#However, they do remember a few key facts about the password:
#
#It is a six-digit number.
#The value is within the range given in your puzzle input.
#Two adjacent digits are the same (like 22 in 122345).
#Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
#Other than the range rule, the following are true:
#
#111111 meets these criteria (double 11, never decreases).
#223450 does not meet these criteria (decreasing pair of digits 50).
#123789 does not meet these criteria (no double).
#How many different passwords within the range given in your puzzle input meet these criteria?
#
#Your puzzle input is 356261-846303.

def possible_passwords (list)
  results = Array.new
  list.each do |x|
    prev_num = 0
    valid_num = true
    x.digits.reverse.each do |digit|
      if digit < prev_num
        valid_num = false
        break
      else
        prev_num = digit
      end
    end
    if valid_num
      results.push(x)
    end
  end
  results
end

possible_nums = Array.new

(356261..846303).map do |x|
  if x.to_s.match?(/((\d)\2)/)
    possible_nums.push(x.to_i)
  end
end

puts possible_passwords(possible_nums).size

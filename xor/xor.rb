#!/usr/bin/ruby

## Find the two numbers with odd occurrences in an unsorted array

require 'pry'

a1 = [1, 2, 1, 3, 4, 3, 2]
a2 = [1, 2, 1, 3, 4, 3, 2, 2]

def xor1(a)
  a.inject(:^)
end

def xor2(a)
  d = a.inject(:^)
  set_bit = d & (~(d - 1))
  a.each_with_object([]) do |e, res|
    # binding.pry
    if e & set_bit != 0
      res[0] = res[0] ? res[0] ^ e : e
    else
      res[1] = res[1] ? res[1] ^ e : e
    end
  end
end

puts "One element = #{xor1(a1)}"
puts "Two elements = #{xor2(a2)}"


#!/usr/bin/ruby

## Find minimal subset of array that grater than given number

a = 15.times.map { rand(1..15) }
b = rand(20..34)

def msub(a, b)
  i = 0
  l = 0
  min_sub = a

  while i < a.size
    sub = a[i..i+l]
    sum = sub.inject(0, :+)
    # puts "i = #{i} l = #{l} sum = #{sum}"

    if sum > b
      min_sub = sub if sub.size < min_sub.size
      i = i + 1
      l = 0
    elsif i + l >= a.size
      i = i + 1
      l = 0
    else
      l = l + 1
    end
  end

  [min_sub, min_sub.inject(0, :+)]
end

puts "A = #{a}"
puts "B = #{b}"
puts "SUB = #{msub(a, b)}"


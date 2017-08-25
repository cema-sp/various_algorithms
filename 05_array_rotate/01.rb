#!/usr/bin/env ruby

def rotate_1(arr, n)
  n.times { rotate_by_one(arr) }
  arr
end

def rotate_by_one(arr)
  return arr unless arr.size > 1

  i = 1
  prev = arr[0]
  while i < arr.size
    tmp = arr[i]
    arr[i] = prev
    prev = tmp
    i += 1
  end
  arr[0] = prev
  arr
end

# another direction!
def rotate_2(arr, n)
  size = arr.size
  return arr unless size > 1

  div = size.gcd(n)
  puts "gcd = #{div}"
  i = 0
  while i < div
    tmp = arr[i]
    j = i

    loop do
      k = (j + div) % size

      puts "i = #{i}, j = #{j}, k = #{k}"

      break if k == i
      arr[j] = arr[k]
      j = k
      puts arr.to_s
    end
    arr[j] = tmp
    puts arr.to_s

    i += 1
  end
  arr
end

require 'pry'; binding.pry

puts 'Done'

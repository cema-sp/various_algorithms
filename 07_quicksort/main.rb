#!/usr/bin/env ruby

# frozen_string_literal: true

$iters = 0

def sort(array)
  return array if array.size <= 1

  base = array[0]

  less = []
  equal = [base]
  greater = []

  i = 1
  while i < array.size
    item = array[i]
    if item < base
      less << item
    elsif item == base
      equal << item
    else
      greater << item
    end
    i += 1
    $iters += 1
  end

  sort(less) + equal + sort(greater)
end

# ------ main ------

arr = [5, 3, 2, 6, 7, 8, 1]

puts "Array:\t#{arr}"

sorted = sort(arr)

puts "Iterations: #{$iters}"
puts "Sorted:\t#{sorted}"

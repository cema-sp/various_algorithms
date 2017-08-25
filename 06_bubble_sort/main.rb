#!/usr/bin/env ruby

# frozen_string_literal: true

def sort(array)
  iters = 0
  sorted = false
  until sorted
    sorted = true
    i = 0
    while i < array.size - 1
      if array[i] > array[i + 1]
        tmp = array[i + 1]
        array[i + 1] = array[i]
        array[i] = tmp
        sorted = false
      end
      i += 1
      iters += 1
    end
  end

  puts "Iterations: #{iters}"
  array
end

# ------ main ------

arr = [5, 3, 2, 6, 7, 8, 1]

puts "Array:\t#{arr}"

sorted = sort(arr)

puts "Sorted:\t#{sorted}"

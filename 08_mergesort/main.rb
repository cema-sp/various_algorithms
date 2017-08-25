#!/usr/bin/env ruby

# frozen_string_literal: true

$iters = 0

# In place sorting

def sort!(array, lo = 0, hi = array.size - 1)
  size = (hi - lo) + 1
  mid = (lo + hi) / 2

  return if size <= 1

  if size > 2
    sort!(array, lo, mid)
    sort!(array, mid + 1, hi)
  end

  merge!(array, lo, mid, hi)

  $iters += 1
end

def merge!(array, lo, mid, hi)
  i = lo
  j = mid + 1

  while j <= hi
    while i <= mid
      if array[i] > array[j]
        swap!(array, i, j)
      end

      $iters += 1
      i += 1
    end
    j += 1
  end
end

def swap!(array, i, j)
  return if i == j

  tmp = array[i]
  array[i] = array[j]
  array[j] = tmp
end

# ------ main ------

arr = [5, 3, 2, 6, 7, 8, 1]

puts "Array:\t#{arr}"

sort!(arr)

puts "Iterations: #{$iters}"
puts "Sorted:\t#{arr}"

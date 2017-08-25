#!/usr/bin/env ruby

# frozen_string_literal: true

$iters = 0

# In place sorting
def sort!(array, lo = 0, hi = array.size - 1)
  return unless lo < hi

  partition_idx = partition_2(array, lo, hi)
  # array[partition_idx] is in the right place

  sort!(array, lo, partition_idx - 1) # sort before
  sort!(array, partition_idx + 1, hi) # sort after
end

# Lomuto
def partition_1(array, lo, hi)
  pivot = array[hi] # last element

  i = (lo - 1) # index of smaller element
  j = lo
  while j < hi
    if array[j] <= pivot
      i += 1
      swap!(array, i, j)
    end

    j += 1
    $iters += 1
  end

  i += 1
  swap!(array, i, hi)
  i
end

# Hoare
def partition_2(array, lo, hi)
  pivot = array[lo]

  i = lo
  j = hi

  loop do
    while array[i] < pivot
      i += 1
    end

    while array[j] > pivot
      j -= 1
    end

    $iters += 1

    if i >= j
      # no swap needed
      return j
    end

    swap!(array, i, j)
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

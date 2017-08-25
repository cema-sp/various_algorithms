#!/usr/bin/env ruby

# frozen_string_literal: true

class Tree
  class Node
    attr_accessor :data, :left, :right

    def initialize(data, left: nil, right: nil)
      @data = data
      @left = left
      @right = right
    end

    def to_s
      "#{data} -> (#{left&.data || '-'}, #{right&.data || '-'})"
    end
  end

  attr_reader :root

  def initialize
    @root = nil
  end

  # pre-order
  def search(data, node = @root)
    return unless node

    puts "\tloooking in #{node}"
    return node if node.data == data

    if data <= node.data
      return search(data, node.left)
    end

    search(data, node.right)
  end

  def insert(data, node = @root)
    unless @root
      return (@root = Node.new(data))
    end

    if data <= node.data
      if node.left
        insert(data, node.left)
      else
        node.left = Node.new(data)
      end
    else
      if node.right
        insert(data, node.right)
      else
        node.right = Node.new(data)
      end
    end
  end

  def delete(data, node = @root, parent = nil)
    if data < node.data
      delete(data, node.left, node) if node.left
    elsif data > node.data
      delete(data, node.right, node) if node.right
    else
      # delete current node
      if node.left && node.right
        min, premin = min_from(node.right, node) # min element in right subtree
        node.data = min.data                     # replace current node with min
        delete(min.data, min, premin)            # remove min node
      elsif node.left
        replace(parent, node, node.left)
      elsif node.right
        replace(parent, node, node.right)
      else
        replace(parent, node, nil)
      end
    end
  end

  def min_from(node, parent)
    if node.left
      min_from(node.left, node)
    else
      [node, parent]
    end
  end

  def replace(parent, node, replacement)
    return unless parent

    if parent.left == node
      parent.left = replacement
    else
      parent.right = replacement
    end
  end

  def traverse_bfs
    return unless @root

    upcoming = Queue.new
    upcoming.enq(@root)

    until upcoming.empty?
      node = upcoming.deq

      yield node

      upcoming.enq(node.left) if node.left
      upcoming.enq(node.right) if node.right
    end
  end

  def traverse_inorder(node = @root, &block)
    return unless @root

    traverse_inorder(node.left, &block) if node.left
    block.call(node)
    traverse_inorder(node.right, &block) if node.right
  end

  def balanced_1
    datas = []
    traverse_inorder { |node| datas << node.data }
    Tree.new.insert_sorted_array(datas)
  end

  def insert_sorted_array(array)
    return if array.empty?

    size = array.size
    mid = array[size / 2]

    l = array[0, size / 2]
    r = array[(size / 2) + 1, size / 2]

    insert(mid)
    insert_sorted_array(l)
    insert_sorted_array(r)

    self
  end

  def to_s
    nodes = []
    traverse_bfs do |node|
      nodes << node.to_s
    end

    nodes.join("\n")
  end
end

# ------ main ------

# $cnt = 0

tree = Tree.new

tree.insert(5)
tree.insert(4)
tree.insert(8)
tree.insert(11)
tree.insert(7)
tree.insert(6)
tree.insert(3)
tree.insert(12)
tree.insert(10)
tree.insert(9)

puts "Tree:"
puts tree.to_s

s = 7
puts "Search #{s}:"
found = tree.search(s)
puts "Found: #{found}"

d = 8
puts "Deleted #{d}:"
tree.delete(d)
puts tree.to_s

bal1 = tree.balanced_1
puts "Balanced 1:"
puts bal1.to_s

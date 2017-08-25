#!/usr/bin/env ruby

# frozen_string_literal: true

class List
  class Node
    attr_reader :data, :prev

    def initialize(data, prev: nil)
      @data = data
      @prev = prev
    end
  end

  def initialize
    @tail = nil
  end

  def add(data)
    @tail = Node.new(data, prev: @tail)
  end

  def each
    node = @tail
    while node
      yield node
      node = node.prev
    end
  end

  def to_s
    datas = []
    each { |node| datas.unshift(node.data.data) }
    datas.join(' -> ')
  end
end

class Graph
  class Vertex
    attr_reader :data, :vertices

    def initialize(data)
      @data = data
      @vertices = List.new
    end

    def link(vertex)
      @vertices.add(vertex)
    end

    def to_s
      "V (#{data}): #{vertices}"
    end
  end

  def initialize
    @vertices = []
  end

  def add(data)
    Vertex.new(data).tap do |vertex|
      @vertices << vertex
    end
  end

  def link(from, to)
    from.link(to)
  end

  def bfs(data)
    visited = []

    @vertices.each do |vertex|
      next if visited.include?(vertex)

      # FIFO => Queue
      upcoming = Queue.new
      upcoming.enq(vertex)
      # puts "\tenq: #{vertex.data}"
      visited << vertex

      until upcoming.empty?
        v = upcoming.deq

        puts "\tchecking #{v.data}"
        return v if v.data == data

        v.vertices.each do |node|
          adj = node.data
          next if visited.include?(adj)
          upcoming.enq(adj)
          # puts "\tenq: #{adj.data}"
          visited << adj
        end
      end
    end
  end

  def dfs(data)
    visited = []

    @vertices.each do |vertex|
      next if visited.include?(vertex)

      # LIFO => Stack
      upcoming = [] # Stack
      upcoming.push(vertex)
      # puts "\tpush: #{vertex.data}"
      visited << vertex

      until upcoming.empty?
        v = upcoming.pop

        puts "\tchecking: #{v.data}"
        return v if v.data == data

        v.vertices.each do |node|
          adj = node.data
          next if visited.include?(adj)

          upcoming.push(adj)
          # puts "\tpush: #{adj.data}"
          visited << adj
        end
      end
    end
  end

  def to_s
    @vertices.map(&:to_s).join("\n")
  end
end

# ------ main ------

graph = Graph.new
a = graph.add('A')
b = graph.add('B')
c = graph.add('C')
d = graph.add('D')
e = graph.add('E')

graph.link(a, b)
graph.link(b, c)
graph.link(b, d)
graph.link(a, e)
graph.link(e, c)

puts "Graph:\n#{graph}"

puts "BFS"
puts "bfs(D): "
puts "  = #{graph.bfs('D')}"
puts "bfs(C): "
puts "  = #{graph.bfs('C')}"

puts "DFS"
puts "dfs(D): "
puts "  = #{graph.dfs('D')}"
puts "dfs(C): "
puts "  = #{graph.dfs('C')}"

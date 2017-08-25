#!/usr/bin/env ruby

# frozen_string_literal: true

class Graph
  class Vertice
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def to_s
      "V (#{data})"
    end
  end

  class Edge
    attr_reader :from, :to

    def initialize(from, to)
      @from = from
      @to   = to
    end
  end

  def initialize
    @vertices = []
    @edges = []
  end

  def add(data)
		vertice = Vertice.new(data)
    @vertices << vertice
		vertice
  end

  def link(from, to)
		edge = Edge.new(from, to)
    @edges << edge
		edge
  end

  def bfs(data)
    # FIFO => queue
    upcoming = Queue.new
    upcoming.enq(@vertices.first)

    visited = []

    until upcoming.empty?
      vertex = upcoming.deq
      visited << vertex

      # next if visited.include?(vertex)
      puts "\tchecking #{vertex}"
      return vertex if vertex.data == data

      edges_from(vertex).
        map(&:to).
        reject { |v| visited.include?(v) }.
        each { |v| upcoming.enq(v) }
    end
  end

  def dfs(data)
    # LIFO => Stack
    visited = []

    @vertices.each do |vertex|
      next if visited.include?(vertex)

      upcoming = []
      upcoming.push(vertex)
      visited << vertex

      until upcoming.empty?
        vertex = upcoming.pop

        puts "\tchecking #{vertex}"
        return vertex if vertex.data == data

        edges_from(vertex).each do |edge|
          v = edge.to

          next if visited.include?(v)
          upcoming.push(v)
          visited << v
        end
      end
    end
  end

  def dfs2(data)
    visited = {}

    result = nil
    @vertices.each do |vertex|
      next if visited[vertex]
      result = _dfs2(data, vertex, visited)
      break if result
    end

    result
  end

  def _dfs2(data, vertex, visited)
    visited[vertex] = true

    adjacent = edges_from(vertex).map(&:to)

    result = nil
    adjacent.each do |adj|
      result = _dfs2(data, adj, visited)
      break if result
    end

    return result if result

    puts "\tchecking #{vertex}"
    return vertex if vertex.data == data
  end

  def to_s
    str = ''
    @vertices.each do |vertice|
      str = "#{str}\n#{vertice}"

      edges_from(vertice).each do |edge|
        str = "#{str}\n  -> #{edge.to}"
      end
    end

    str
  end

  private

  def edges_from(vertice)
    @edges.select { |edge| edge.from == vertice }
  end

  def edges_to(vertice)
    @edges.select { |edge| edge.to == vertice }
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

puts "DFS recirsive"
puts "dfs(D): "
puts "  = #{graph.dfs2('D')}"
puts "dfs(C): "
puts "  = #{graph.dfs2('C')}"

#!/usr/bin/env ruby

# frozen_string_literal: true

class Graph
  def initialize
    @matrix = []
    @datas = []
  end

  def add(data)
    idx = @datas.size
    @datas[idx] = data

    size = @matrix.size

    @matrix.map! do |row|
      row ||= []
      row << false
    end

    @matrix << Array.new(size + 1, false)

    idx
  end

  def link(from, to)
    @matrix[from][to] = true
  end

  def bfs(data)
    size = @matrix.size
    visited = Array.new(size, false)

    (0...size).each do |idx|
      next if visited[idx]

      upcoming = Queue.new
      upcoming.enq(idx)
      visited[idx] = true

      until upcoming.empty?
        i = upcoming.deq

        puts "\tchecking: #{@datas[i]}"
        return @datas[i] if @datas[i] == data

        @matrix[i].each_with_index do |conn, j|
          next unless conn
          next if visited[j]
          upcoming.enq(j)
          visited[j] = true
        end
      end
    end
  end

  def dfs(data)
    size = @matrix.size
    visited = Array.new(size, false)

    (0...size).each do |idx|
      next if visited[idx]

      result = _dfs(data, idx, visited)
      next unless result

      return result
    end
    nil
  end

  def _dfs(data, idx, visited)
    visited[idx] = true

    puts "\tchecking: #{@datas[idx]}"
    return @datas[idx] if @datas[idx] == data

    @matrix[idx].each_with_index do |conn, j|
      next unless conn

      result = _dfs(data, j, visited)
      next unless result

      return result
    end

    nil
  end

  def to_s
    header = "   #{@datas.join(' ')}"

    rows = @matrix.map.with_index do |row, idx|
      cols = row.map { |v| v ? '+' : '.' }.join(' ')
      "#{@datas[idx]}: #{cols}"
    end

    "#{header}\n#{rows.join("\n")}"
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

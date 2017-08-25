#!/usr/bin/ruby

# N = size
class LinkedList
  def initialize
    @first = nil
    @last = nil
  end

  def first
    @first&.val
  end

  def last
    @last&.val
  end

  # O(1)
  def unshift(val)
    if @first
      item = Item.new(prv: @first, val: val)
      @first.nxt = item
      @first = item
    else
      @last = Item.new(val: val)
      @first = @last
    end
  end

  # O(1)
  def push(val)
    if @last
      item = Item.new(nxt: @last, val: val)
      @last.prv = item
      @last = item
    else
      @first = Item.new(val: val)
      @last = @first
    end
  end

  # O(N)
  def delete(val)
    current = @last
    while current
      break unless current
      if current.val == val
        @last = current.nxt if @last == current
        @first = current.prv if @first == current
        current.nxt.prv = current.prv if current.nxt
        current.prv.nxt = current.nxt if current.prv
      end
      current = current.nxt
    end
  end

  def show
    vals = []
    current = @last
    while current
      break unless current
      vals << current.val
      current = current.nxt
    end

    vals.join(' -> ')
  end

  def show_reverse
    vals = []
    current = @first
    while current
      break unless current
      vals << current.val
      current = current.prv
    end

    vals.join(' <- ')
  end

  class Item
    attr_accessor :nxt, :prv, :val

    def initialize(nxt: nil, prv: nil, val:)
      @nxt = nxt
      @prv = prv
      @val = val
    end
  end
end

# N = size
class Cache
  attr_reader :size

  def initialize(size:)
    @size = size
    @values = {}
    @reads = LinkedList.new
  end

  # O(N + N + 1 || N + N + 1 || 1) = O(N)
  def add(key, val)
    if @values.key?(key)
      @reads.delete(key)
    elsif @values.size == size
      @values.delete(@reads.last)
      @reads.delete(@reads.last)
    end

    @values[key] = val
    @reads.unshift(key)
  end

  def show
    puts "Chache:"
    @values.each do |k, v|
      puts "\t#{k} -- #{v}"
    end
    puts "Reads: #{@reads.show}"
  end
end

# ------ main ------

cache = Cache.new(size: 3)

cache.add(10, 100)
cache.add(20, 200)
cache.add(30, 300)
cache.add(20, 220)
cache.add(10, 110)
cache.add(30, 330)
cache.add(40, 400)
cache.add(30, 333)
cache.add(40, 440)
cache.add(10, 111)
cache.add(50, 500)

cache.show

#!/usr/bin/ruby

# N = size
class Cache
  attr_reader :size

  def initialize(size:)
    @size = size
    @cache = {}
    @times = {}
  end

  # O(N + N) = O(N)
  def add(key, value)
    if !@cache.has_key?(key) && @cache.size == size
      remove_least_recent
    end

    @cache[key] = value
    @times[key] = Time.now.to_i
  end

  def show
    puts "\nCache:\n"
    puts @cache
  end

  private

  # O(N + N + N) = O(N)
  def remove_least_recent
    record = @times.min_by { |k, v| v }
    key = record.first
    @times.delete(key)
    @cache.delete(key)
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

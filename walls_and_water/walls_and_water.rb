#!/usr/bin/env ruby

require 'minitest'
require 'minitest/spec'

class WallsAndWater
  attr_reader :walls

  def initialize(walls)
    @walls = walls
  end

  def solve
    water = 0
    maybe_water = 0
    prev = 0
    left = nil
    left_idx = nil

    walls.each_with_index do |wall, idx|
      if left
        # in water
        if wall < prev
          maybe_water += (left - wall)
        else
          if wall >= left
            left = nil
            left_idx = nil
            water += maybe_water
            maybe_water = 0
          else
            maybe_water += (left - wall)
          end
        end
      else
        # not in water
        if wall < prev
          left = prev
          left_idx = idx - 1
          maybe_water += (left - wall)
        else
          # do nothing
        end
      end

      prev = wall
    end

    if left && maybe_water > 0
      overflow = (left - walls.last) * (walls.size - (left_idx + 1))
      water += (maybe_water - overflow)
    end

    water
  end

  def to_s
    max_wall = walls.max
    walls_str = Array.new(walls.size) { Array.new(max_wall) { ' ' } }

    walls.each_with_index do |wall, i|
      (0...wall).each do |j|
        walls_str[i][j] = '#'
      end
    end

    walls_str.transpose.reverse.map { |w| w.join }.join("\n")
  end
end

# ------ tests ------

describe WallsAndWater do
  let(:waw) { WallsAndWater.new(array) }

  describe '#solve' do
    subject { waw.solve }

    describe 'when no water' do
      let(:array) { [1, 2, 3, 4, 5] }

      it 'returns 0' do
        subject.must_equal 0
      end
    end

    describe 'when 1 water' do
      let(:array) { [1, 2, 1, 4, 5] }

      it 'returns 1' do
        subject.must_equal 1
      end
    end

    describe 'when water divided' do
      let(:array) { [1, 2, 1, 4, 1, 3] }

      it 'returns 3' do
        subject.must_equal 3
      end
    end

    describe 'when water with riff' do
      let(:array) { [3, 1, 1, 2, 1, 3] }

      it 'returns 7' do
        subject.must_equal 7
      end
    end

    describe 'when water ends after left wall' do
      let(:array) { [4, 1, 2, 1, 3] }

      it 'returns 5' do
        subject.must_equal 5
      end
    end

    describe 'when water is full' do
      let(:array) { [4, 1, 1, 1, 4] }

      it 'returns 9' do
        subject.must_equal 9
      end
    end
  end
end

# ------ main ------

if_test = ARGV[0]

fail 'No array / "test" provided' unless if_test

if if_test == 'test'
  Minitest.autorun

  exit(0)
end

array = ARGV.map(&:to_i)

waw = WallsAndWater.new(array)
water = waw.solve

puts "Water: #{water}"
puts "Picture:"
puts waw

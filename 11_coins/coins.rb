#!/usr/bin/env ruby
# frozen_string_literal: true

class Changer
  COIN_VALUES = {
    penny:    1,
    nickel:   5,
    dime:     10,
    quarter:  25,
    half:     50,
    ike:      100
  }.freeze

  attr_reader :coin_types

  def initialize
    @coin_types = COIN_VALUES.keys
  end

  def change(amount = 0)
    chg = coin_types.each_with_object({}) { |type, acc| acc[type] = 0 }
    chg = change_rest(amount, chg)

    show(chg)
  end

  def show(chg)
    str = 'Change:'
    chg.each do |type, number|
      next if number.zero?
      value = COIN_VALUES[type]
      line = "\t#{number}\tx #{type} (#{value})"
      str = "#{str}\n#{line}"
    end
    str
  end

  private

  def change_rest(amount, chg, prev_type = nil)
    type, value = next_coin(prev_type)
    puts "Next: #{type} (#{value})"

    if type == nil
      puts "Amount left: #{amount}"
      return chg
    end

    return change_rest(amount, chg, type) if amount < value

    rest = amount
    coins = rest / value
    if coins > 0
      chg[type] = coins
      rest -= coins * value
    end

    change_rest(rest, chg, type)
  end

  def next_coin(prev_type = nil)
    prev_idx = coin_types_ordered.find_index { |t, _v| t == prev_type }
    current_idx = prev_idx ? prev_idx.succ : 0 # for prev_type = nil

    coin_types_ordered[current_idx]
  end

  def coin_types_ordered
    @coin_types_ordered ||=
      COIN_VALUES.
      select { |type, _value| coin_types.include?(type) }.
      sort_by(&:last).
      reverse
  end
end

# ------ main ------

amount = ARGV[0]&.to_i

changer = Changer.new
puts changer.change(amount)

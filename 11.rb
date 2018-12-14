#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = 7139

class PartOne
  def initialize(input)
    @input = input
    @rack_ids = {}
  end

  attr_reader :input

  def answer
    answer = (0..297).flat_map do |x|
      (0..296).map { |y| [x, y, grid_value(x, y)] }
    end.max_by{|x|x.last}

    [answer.first+1,answer[1]+1].join(',')
  end

  def power_level(x, y)
    ((rack_id(x) * y + input) * rack_id(x)).digits[2] - 5
  end

  def rack_id(x)
    @rack_ids[x] ||= x + 10
  end

  def grid_value(x, y)
    (0..2).sum do |dx|
      (0..2).sum do |dy|
        power_map[x + dx][y + dy]
      end
    end
  end

  def power_map
    @power_map ||= (1..300).map do |x|
      (1..300).map { |y| power_level(x, y) }
    end
  end
end

puts "Part One: #{PartOne.new(INPUT).answer}"

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
      (0..297).map { |y| [x, y, grid_value(x, y, 3)] }
    end.max_by{|x|x.last}

    [answer.first+1,answer[1]+1].join(',')
  end

  def power_level(x, y)
    ((rack_id(x) * y + input) * rack_id(x)).digits[2] - 5
  end

  def rack_id(x)
    @rack_ids[x] ||= x + 10
  end

  def grid_value(x, y, size)
    (0..(size - 1)).sum do |dx|
      (0..(size - 1)).sum do |dy|
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

class PartTwo < PartOne
  def answer
    answer =
      (1..300).pmap(300) do |size|
        (0..(300 - size)).flat_map do |x|
          (0..(300 - size)).map do |y|
            [x, y, size, grid_value(x, y, size)]
          end
        end.max_by{|x|x.last}
      end

    [answer.first+1,answer[1]+1,answer[2]].join(',')
  end
end

puts "Part Two: #{PartTwo.new(INPUT).answer}"

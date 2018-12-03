#!/usr/bin/env ruby
require_relative 'bootstrap'
require_relative '03/input.rb'

class Claim
  PATTERN = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/
  def initialize(spec)
    match = PATTERN.match(spec)
    @id = match[1]
    @x = match[2].to_i
    @y = match[3].to_i
    @width = match[4].to_i
    @height = match[5].to_i
  end

  attr_reader :id, :x, :y, :width, :height

  def ==(other_object)
    other_object.id == id
  end

  def tiles_covered
    @tiles_covered ||=
      (0...height).flat_map do |y2|
        (0...width).map do |x2|
          [x2 + x, y2 + y]
        end
      end.to_set
  end
end

class DayThree
  def initialize(input)
    @input = input
    @claims = input.map { |c| Claim.new(c) }
    @blah = Hash.new do |hash, key|
      hash[key] = []
    end
  end

  def part_one
    claims.each do |c|
      c.tiles_covered.each do |t|
        blah[t] << c
      end
    end

    blah.select do |k, v|
      v.length >= 2
    end.length
  end

  # This works.
  def part_two
    rejects = blah.values.reject{|v|v.count < 2}.flatten.uniq
    (claims - rejects).first.id
  end

  private

  attr_reader :input, :claims, :blah
end

solution = DayThree.new(INPUT)

puts "Part one: #{solution.part_one}"
puts "Part two: #{solution.part_two}"

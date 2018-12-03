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
  end

  def part_one
    blah = Hash.new do |hash, key|
      hash[key] = []
    end

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
    claims.find do |c1|
      claims.all? do |c2|
        c1.id == c2.id || c1.tiles_covered.disjoint?(c2.tiles_covered)
      end
    end.id
  end

  private

  attr_reader :input, :claims
end

solution = DayThree.new(INPUT)

puts "Part one: #{solution.part_one}"
puts "Part two: #{solution.part_two}"

#!/usr/bin/env ruby
require_relative 'bootstrap'
require_relative '03/input.rb'

class DayThree
  def initialize(input)
    @input = input
  end

  def part_one
    input
  end

  def part_two
    input
  end

  private

  attr_reader :input
end

solution = DayThree.new(INPUT)

puts "Part one: #{solution.part_one}"
puts "Part two: #{solution.part_two}"

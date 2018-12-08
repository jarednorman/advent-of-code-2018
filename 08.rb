#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = File.open('08.txt').read.lines.map(&:chomp)

class Problem
  def initialize(input)
    @input = input
  end

  attr_reader :input
end

class PartOne < Problem
  def answer
    "who knows?"
  end
end

puts "Part One: #{PartOne.new(INPUT).answer}"

class PartTwo < Problem
  def answer
    "who knows?"
  end
end

puts "Part Two: #{PartTwo.new(INPUT).answer}"

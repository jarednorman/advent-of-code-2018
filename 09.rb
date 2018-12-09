#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = File.open('09.txt').read.chomp.split(' ').map(&:to_i)

class Problem
  def initialize(input)
    @input = input.dup
  end

  attr_reader :input
end

class PartOne < Problem
  def answer
  end
end

puts "Part One: #{PartOne.new(INPUT).answer}"

class PartTwo < Problem
  def answer
  end
end

puts "Part Two: #{PartTwo.new(INPUT).answer}"

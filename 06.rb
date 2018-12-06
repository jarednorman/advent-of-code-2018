#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = File.open('06.txt').read.lines.map(&:chomp).map do |line|
  line.split(", ").map(&:to_i)
end

class PartOne
  def initialize(input)
    @input = input
  end

  attr_reader :input

  def answer
    binding.pry
  end
end

puts "Part One:"
puts PartOne.new(INPUT.dup).answer.inspect

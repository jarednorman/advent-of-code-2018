#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = File.open('05_input.txt').read.lines.map(&:chomp)

class PartOne
  def initialize(input)
    @input = input
  end

  def answer
    input
  end

  attr_reader :input
end

puts "Part one: #{PartOne.new(INPUT).answer}"

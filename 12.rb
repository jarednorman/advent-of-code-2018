#!/usr/bin/env ruby
require_relative 'bootstrap'

class PartOne
  def initialize(input)
    @input = input
  end

  attr_reader :input

  def answer
  end
end

puts "Part One: #{PartOne.new(INPUT).answer}"

#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = File.open('05_input.txt').read.chomp

BAD_COMBOS = ('a'..'z').flat_map{|l|[[l,l.capitalize].join,[l.capitalize,l].join]}

class PartOne
  def initialize(input)
    @input = input
  end

  def answer
    new_length = 99999999999999999999

    while new_length != input.length
      new_length = input.length
      BAD_COMBOS.each{|x|input.gsub!(x, '')}
    end

    input.length
  end

  attr_reader :input
end

# puts "Part one: #{PartOne.new(INPUT).answer}"

class PartOneNoMuties
  def initialize(input)
    @input = input
  end

  def answer
    new_length = 99999999999999999999

    while new_length != input.length
      new_length = input.length
      BAD_COMBOS.each{|x|self.input = input.gsub(x, '')}
    end

    input.length
  end

  attr_accessor :input
end

class PartTwo
  def initialize(input)
    @input = input
  end

  def answer
    ('a'..'z').map do |x|
      i = input.gsub(x, '').gsub(x.upcase, '')
      PartOneNoMuties.new(i).answer
    end.min
  end

  attr_reader :input
end

puts "Part two: #{PartTwo.new(INPUT).answer}"

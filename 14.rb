#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = '503761'

class PartOne
  def initialize(input)
    @input = input
    @state = '37'
    @a = 0
    @b = 1
    @step = 0
  end

  attr_reader :input
  attr_accessor :a, :b, :state

  def step
    @step += 1
    a_score = state[a].to_i
    b_score = state[b].to_i

    total = (a_score + b_score).to_s
    self.state << total

    stl = state.length
    self.a = (a + 1 + a_score) % stl
    self.b = (b + 1 + b_score) % stl

    if @step % 100000 == 0
      puts @step
    end

    total.length
  end

  def answer
    until state.length >= input.to_i + 10
      step
    end

    state.slice(input.to_i, 10).join
  end

  def draw
    puts(state.each_with_index.map do |c,i|
      if i == a
        "(#{c})"
      elsif b == i
        "[#{c}]"
      else
        " #{c} "
      end
    end.join)
  end
end

# test = PartOne.new(INPUT)
# loop do
#   test.draw
#   gets
#   test.step
# end
# puts "Test: #{test.state}"
# puts "Part One: #{PartOne.new(INPUT).answer}"

class PartTwo < PartOne
  def answer
    25000000.times { step }
    # raise if state.include? input
    return state.index(input)
  end
end
#puts PartTwo.new('51589').answer
#puts PartTwo.new('01245').answer
#puts PartTwo.new('92510').answer
#puts PartTwo.new('59414').answer
puts "Part Two: #{PartTwo.new(INPUT).answer}"

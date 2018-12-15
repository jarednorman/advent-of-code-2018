#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = 503761

class PartOne
  def initialize(input)
    @input = input
    @state = [3, 7]
    @a = 0
    @b = 1
  end

  attr_reader :input
  attr_accessor :a, :b, :state

  def step
    a_score = state[a]
    b_score = state[b]

    total = a_score + b_score
    self.state = state + total.to_s.split('').map(&:to_i)

    self.a = (a + 1 + a_score) % state.length
    self.b = (b + 1 + b_score) % state.length
  end

  def answer
    until state.length >= input + 10
      step
      puts state.length if state.length % 1000 == 0
    end

    state.slice(input, 10).join
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
puts "Part One: #{PartOne.new(INPUT).answer}"

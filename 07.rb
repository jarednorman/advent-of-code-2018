#!/usr/bin/env ruby
require_relative 'bootstrap'

Constraint = Struct.new(:step, :dependency)

INPUT = File.open('07.txt').read.lines.map(&:chomp).map do |line|
  _,dependency,step = */Step (.) must.*step (.)/.match(line)
  Constraint.new(step, dependency)
end

Step = Struct.new(:letter) do
  def dependencies
    @dependencies ||= Set.new
  end
end

steps = ('A'..'Z').map do |letter|
  [letter, Step.new(letter)]
end.to_h

INPUT.each do |c|
  steps[c.step].dependencies << c.dependency
end

steps = steps.values

# order = []

# while steps.any?
#   steps.each do |step|
#     next unless step.dependencies.empty?
#     order << step.letter
#     steps.each do |x|
#       x.dependencies.delete(step.letter)
#     end
#     steps.delete(step)
#     break
#   end
# end

# puts "Part One: #{order.join}"

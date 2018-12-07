#!/usr/bin/env ruby
require_relative 'bootstrap'

Constraint = Struct.new(:step, :dependency)

INPUT = File.open('07.txt').read.lines.map(&:chomp).map do |line|
  _,dependency,step = */Step (.) must.*step (.)/.match(line)
  Constraint.new(step, dependency)
end

LETTERS = ('A'..'Z').to_a

Step = Struct.new(:letter) do
  def dependencies
    @dependencies ||= Set.new
  end

  def length
    @length ||= LETTERS.index(letter) + 61
  end
end

steps = LETTERS.map do |letter|
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

class Worker
  def initialize(steps)
    @steps = steps
    @time = 0
    @end_time = nil
    @job = nil
  end

  def step!
    if time == end_time
      self.end_time = nil
      steps.each do |step|
        step.dependencies.delete(job.letter)
      end
      self.job = nil
    end

    start_a_job! if idle?

    @time += 1
  end

  def idle?
    @job.nil?
  end

  attr_reader :time, :steps
  attr_accessor :job, :end_time

  def start_a_job!
    self.job = steps.find{|j|j.dependencies.empty?}
    return unless job
    steps.delete(job)
    self.end_time = time + job.length
  end
end

# 0 1 2 3 4
# A A A

workers = 5.times.map do
  Worker.new(steps)
end

loop do
  workers.each(&:step!)

  if workers.all?(&:idle?)
    puts "Part Two: #{workers.first.time - 1}"
    break
  end
end

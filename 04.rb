#!/usr/bin/env ruby
require_relative 'bootstrap'
require 'date'

INPUT = File.open('04_input.txt').read.lines.map(&:chomp)

class Shift
  def initialize(lines)
    _, @start, @id = */\[(.*)\] Guard #(\d+)/.match(lines.shift)
    @id = @id.to_i
    @start = DateTime.parse(@start)

    @lines = lines
  end

  def minutes_asleep
    @lines.each_slice(2).sum do |x|
      x = x.map {|z| DateTime.parse(z).minute}
      start, finish = *x
      finish ||= 60
      finish - start
    end
  end

  def specific_minutes
    @lines.each_slice(2).flat_map do |x|
      x = x.map {|z| DateTime.parse(z).minute}

      start, finish = *x
      finish ||= 60
      (start...finish).to_a
    end
  end

  attr_reader :timestamp, :id
end

shifts = []

current_shift_lines = []
INPUT.each do |line|
  if line.include?("begins shift") && current_shift_lines.any?
    shifts << Shift.new(current_shift_lines)
    current_shift_lines = []
  end

  current_shift_lines << line
end

grouped = shifts.group_by(&:id)

worst_id = grouped.transform_values{|x|x.sum(&:minutes_asleep)}.max_by{|(x,y)|y}.first
puts "Sleepiest ID: #{worst_id}"

worst_shifts = grouped[worst_id]

s = Hash.new 0
worst_shifts.flat_map(&:specific_minutes).each do |x|
  s[x] += 1
end

best_minute = s.max_by{|(k,v)|v}.first

puts "Best Minute: #{best_minute}"
puts "Result: #{worst_id}x#{best_minute}=#{worst_id*best_minute}"

puts "\nPART TWO\n"

some_things = grouped.transform_values do |v|
  v.flat_map(&:specific_minutes).group_by{|x|x}.map{|(x,y)|[x, y.count]}.max_by(&:last) || [0, 0]
end

result = some_things.max_by{|(x,y)|y.last}

guard = result.first
minute = result.last.first

puts "Best Guard: #{guard}"
puts "Best Minute: #{minute}"
puts "Part two: #{guard * minute}"

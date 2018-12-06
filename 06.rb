#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = File.open('06.txt').read.lines.map(&:chomp).each_with_index.map do |line,i|
  x,y = *line.split(", ").map(&:to_i)
  {id:i,x:x,y:y}
end

class PartOne
  def initialize(input)
    @input = input

    height = input.map{|x|x[:y]}.max + 1
    width = input.map{|x|x[:x]}.max + 1

    @board = width.times.map{height.times.map{nil}}
  end

  attr_reader :input, :board

  def answer
    c = board.each_with_index.map do |column,x|
      column.each_with_index.map do |_,y|
        distances = input.map do |loc|
          {
            id: loc[:id],
            distance: distance(loc[:x], loc[:y], x, y)
          }
        end

        min_distance = distances.min_by{|x|x[:distance]}

        if distances.count{|x|x[:distance] == min_distance[:distance]} == 1
          min_distance[:id]
        else
          'x'
        end
      end
    end

    draw(c)

    results = c.flatten.group_by{|x|x}.transform_values(&:count)

    results.delete("x")

    c.first.uniq.each do |id|
      puts "Eliminating: #{id}"
      results.delete(id)
    end

    c.last.uniq.each do |id|
      puts "Eliminating: #{id}"
      results.delete(id)
    end

    c.each do |column|
      puts "Eliminating: #{column.first}"
      results.delete(column.first)
      puts "Eliminating: #{column.last}"
      results.delete(column.last)
    end

    results.values
  end

  def distance(x1,y1,x2,y2)
    (x1 - x2).magnitude + (y1 - y2).magnitude
  end

  def draw(c)
    c.first.length.times.map do |y|
      puts c.map{|col|col[y].to_s.rjust(3, "0")}.join " "
      puts
    end
  end
end

#puts "Part One:"
#puts PartOne.new(INPUT.dup).answer.inspect

class PartTwo
  def initialize(input)
    @input = input

    @height = input.map{|x|x[:y]}.max + 1
    @width = input.map{|x|x[:x]}.max + 1
  end

  attr_reader :input, :height, :width

  LIMIT = 10000

  def answer
    count = 0
    width.times do |x|
      height.times do |y|
        total = 0
        input.each do |loc|
          total += distance(x,y,loc[:x],loc[:y])
          break if total >= LIMIT
        end

        count += 1 if total < LIMIT
      end
    end
    count
  end

  def distance(x1,y1,x2,y2)
    (x1 - x2).magnitude + (y1 - y2).magnitude
  end
end

puts "Part Two:"
puts PartTwo.new(INPUT.dup).answer.inspect

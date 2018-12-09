#!/usr/bin/env ruby
require_relative 'bootstrap'

PLAYER_COUNT = 455
LAST_MARBLE = 71223

class Player
  def initialize
    @score = 0
  end

  attr_accessor :score
end

class PartOne
  def initialize(player_count, last_marble, print: false)
    @players = player_count.times.map { Player.new }
    @marbles = (0..last_marble).to_a
    @circle = []
    @print = print
  end

  def answer
    players.cycle.each do |player|
      marble = marbles.shift
      break unless marble

      play(player, marble)
    end

    players.map(&:score).max
  end

  def play(player, marble)
    if marble % 1000 == 0
      puts "#{(marble.to_f/marbles.last*100).round(3)}% done"
    end

    if circle == []
      circle << marble
      self.current_marble = marble
    elsif marble % 23 == 0
      player.score += marble
      player.score += circle.delete_at(compute_index(-7))
      self.current_marble = circle[compute_index(-6)]
    else
      circle.insert(compute_index(2), marble)
      self.current_marble = marble
    end

    if @print
      puts(circle.map do |n|
        if n == current_marble
          "(#{n})"
        else
          n
        end
      end.join(' '))
    end
  end

  def compute_index(offset)
    current_index = circle.index(current_marble)
    index = (current_index + offset)

    while index > circle.length
      index -= circle.length
    end

    while index < 1
      index += circle.length
    end

    index
  end

  attr_reader :players, :circle, :marbles
  attr_accessor :current_marble
end


def check(player_count, last_marble, answer)
  puts "Player Count:\t\t#{player_count}"
  puts "Last Marble:\t\t#{last_marble}"
  puts "Expected Answer:\t#{answer}"
  puts "Actual Answer:\t\t#{PartOne.new(player_count, last_marble).answer}\n\n"
end

#puts PartOne.new(9, 25, print: true).answer
check(10, 1618, 8317)
check(13, 7999, 146373)
check(17, 1104, 2764)
check(21, 6111, 54718)
check(30, 5807, 37305)

puts "Part One: #{PartOne.new(PLAYER_COUNT, LAST_MARBLE).answer}\n\n"
puts "Part Two: #{PartOne.new(PLAYER_COUNT, LAST_MARBLE * 100).answer}"

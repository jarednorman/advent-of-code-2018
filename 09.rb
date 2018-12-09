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
  def initialize(player_count, last_marble)
    @players = player_count.times.map { Player.new }
    @marbles = (0..last_marble).to_a
    @circle = []
  end

  def answer
    @players.cycle.each do |player|
      marble = @marbles.shift
      break unless marble

      play(player, marble)
    end

    players.map(&:score).max
  end

  def play(player, marble)
    player.score += 19
  end

  attr_reader :players
end


def check(player_count, last_marble, answer)
  puts "Player Count:\t\t#{player_count}"
  puts "Last Marble:\t\t#{last_marble}"
  puts "Expected Answer:\t#{answer}"
  puts "Actual Answer:\t\t#{PartOne.new(player_count, last_marble).answer}\n\n"
end

check(10, 1618, 8317)
check(13, 7999, 146373)
check(17, 1104, 2764)
check(21, 6111, 54718)
check(30, 5807, 37305)

puts "Part One: #{PartOne.new(PLAYER_COUNT, LAST_MARBLE).answer}\n\n"

class PartTwo
  def initialize(player_count, last_marble)
  end

  def answer
  end
end

puts "Part Two: #{PartTwo.new(PLAYER_COUNT, LAST_MARBLE).answer}"

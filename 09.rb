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

Node = Struct.new(:value, :prev, :next) do
  def offset(n)
    node = self

    if n > 0
      n.times { node = node.next }
    elsif n < 0
      n.magnitude.times { node = node.prev }
    end

    node
  end

  def verify!
    binding.pry unless self.next.prev.value == value && prev.next.value == value
  end

  def insert_after(value)
    node = Node.new(value, self, self.next)

    node.next.prev = node
    node.prev.next = node

    node
  end

  def remove!
    self.prev.next = self.next
    self.next.prev = self.prev

    self
  end
end

class PartOne
  def initialize(player_count, last_marble, print: false)
    @players = player_count.times.map { Player.new }
    @last_marble = last_marble
    @print = print
  end

  def answer
    (0..@last_marble).zip(players.cycle).each do |(marble, player)|
      if !current_marble
        self.current_marble = Node.new(marble, nil, nil)
        current_marble.next = current_marble
        current_marble.prev = current_marble
      elsif marble % 23 == 0
        player.score += marble
        removed = current_marble.offset(-7)
        self.current_marble = removed.next
        removed.remove!
        player.score += removed.value
      else
        self.current_marble = current_marble.offset(1).insert_after(marble)
      end

      # current_marble.verify!

      if @print
        x = ["(#{current_marble.value})"]
        n = current_marble.next
        while n != current_marble
          x << n.value
          n = n.next
        end

        z = x.index(0) || x.index('(0)')
        puts x.rotate(z).join(' ')
      end
    end

    players.map(&:score).max
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
#
puts "Part One: #{PartOne.new(PLAYER_COUNT, LAST_MARBLE).answer}\n\n"
puts "Part Two: #{PartOne.new(PLAYER_COUNT, LAST_MARBLE * 100).answer}"

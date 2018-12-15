#!/usr/bin/env ruby
require_relative 'bootstrap'

NOTHING = ' '
INTERSECTION = '+'
ROAD_HORIZONTAL = '-'
ROAD_VERTICAL = '|'
TURN_BACK = '\\'
TURN_FORWARD = '/'

class Cart
  MAPPING = {
    '<' => :left,
    '>' => :right,
    '^' => :up,
    'v' => :down
  }

  def initialize(icon, x, y)
    @direction = MAPPING[icon]
    @x = x
    @y = y
  end

  attr_reader :direction, :x, :y
end

class Map
  def lookup x, y
    map[y][x]
  end

  def map
    @map ||= File.read('13.txt').lines.map do |line|
      if line[-1] == "\n"
        line.slice(0, line.length - 1)
      else
        line
      end.split('')
    end
  end

  def extract_carts!
    map.each_with_index.flat_map do |line, y|
      line.each_with_index.flat_map do |char, x|
        if Cart::MAPPING.keys.include? char
          line[x] = {
            '>' => '-',
            '<' => '-',
            '^' => '|',
            'v' => '|'
          }[char]

          Cart.new(char, x, y)
        end
      end
    end.compact
  end
end

class Round
  def initialize(map, carts)
    @map = map
    @carts = carts
    @tick = 0
  end

  attr_reader :map, :carts

  def tick!
    binding.pry
    @tick += 1
  end
end

map = Map.new
round = Round.new(map, map.extract_carts!)

loop do
  round.tick!
rescue => e
  puts "Part One: #{e.message}"
  exit
end

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
    @turn = :left
  end

  attr_reader :x, :y
  attr_accessor :direction

  XMAP = {
    up: 0,
    down: 0,
    left: -1,
    right: 1
  }
  YMAP = {
    up: -1,
    down: 1,
    left: 0,
    right: 0
  }
  def advance!
    @x += XMAP[direction]
    @y += YMAP[direction]
  end

  TURN_LEFT = {
    up: :left,
    down: :right,
    left: :down,
    right: :up
  }
  TURN_RIGHT = {
    up: :right,
    down: :left,
    left: :up,
    right: :down
  }

  def turn!
    if @turn == :left
      self.direction = TURN_LEFT[direction]
      @turn = :center
    elsif @turn == :right
      self.direction = TURN_RIGHT[direction]
      @turn = :left
    else
      @turn = :right
    end
  end
end

class Map
  def look_up x, y
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
    @carts = Set.new(carts)
    @tick = 0
  end

  attr_reader :map, :carts

  CART_POSITION = {
    [TURN_BACK,    :left]  => :up,
    [TURN_FORWARD, :right] => :up,
    [TURN_BACK,    :right] => :down,
    [TURN_FORWARD, :left]  => :down,
    [TURN_BACK,    :up]    => :left,
    [TURN_FORWARD, :down]  => :left,
    [TURN_BACK,    :down]  => :right,
    [TURN_FORWARD, :up]   =>  :right
  }

  INVERT = Cart::MAPPING.invert

  def render
    puts map.map.first.map{' '}.join
    puts map.map.first.map{'#'}.join
    puts map.map.first.map{' '}.join
    puts "#{@tick}:"
    puts map.map.first.map{' '}.join
    grouped = carts.group_by{|c|[c.x, c.y]}

    map.map.each_with_index do |row, y|
      puts(row.each_with_index.map do |char, x|
        j = grouped[[x,y]]

        if !j
          char
        elsif j.length == 1
          c = INVERT[j.first.direction]
          "\033[7m#{c}\033[m"
        elsif j.length > 1
          "\033[7mX\033[m"
        end
      end.join)
    end
  end

  def tick!
    ordered_carts.each do |cart|
      current_tile = look_up(cart.x, cart.y)
      cart.advance!
      new_tile = look_up(cart.x, cart.y)

      cart.direction = CART_POSITION[[new_tile, cart.direction]] || cart.direction

      if new_tile == INTERSECTION
        cart.turn!
      end

      carts.group_by{|c|[c.x, c.y]}.values.each do |cs|
        carts.subtract(cs) if cs.length > 1
      end
    end

      if carts.length == 1
        raise [carts.first.x, carts.first.y].join(',')
      end

    @tick += 1
  end

  def ordered_carts
    carts.sort_by do |cart|
      [cart.y, cart.x]
    end
  end

  def look_up(x, y)
    map.look_up(x, y)
  end
end

map = Map.new
round = Round.new(map, map.extract_carts!)

loop do
  round.tick!
rescue => e
  round.render
  puts "Part Two: #{e.message}"
  exit
end

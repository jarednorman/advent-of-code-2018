#!/usr/bin/env ruby
require_relative 'bootstrap'

class Light
  def initialize(x:,y:,vx:,vy:)
    @x,@y,@vx,@vy = x, y, vx, vy
  end

  attr_reader :x, :y, :vx, :vy

  def step!
    @x += vx
    @y += vy
  end
end

LIGHTS = File.open('10.txt').read.lines.map do |line|
  _,x,y,vx,vy = */.*<(.*),(.*)>.*<(.*),(.*)>/.match(line)
  Light.new(x: x.chomp.to_i, y: y.chomp.to_i, vx: vx.chomp.to_i, vy: vy.chomp.to_i)
end

class Board
  def initialize(input)
    @lights = input.read.lines.map do |line|
  _,x,y,vx,vy = */.*<(.*),(.*)>.*<(.*),(.*)>/.match(line)
  Light.new(x: x.chomp.to_i, y: y.chomp.to_i, vx: vx.chomp.to_i, vy: vy.chomp.to_i)
end
  end

  def run!
    10880.times { lights.each(&:step!) }
    print_board
  end

  def print_board
    xs = lights.map(&:x)
    minx = xs.min
    maxx = xs.max

    ys = lights.map(&:y)
    miny = ys.min
    maxy = ys.max

    xspread = maxx - minx
    yspread = maxy - miny

    puts [xspread, yspread].inspect

    lookup = lights.group_by{|l|l.y}

    return unless xspread < 300
    (miny..maxy).map do |y|
      row = (minx..maxx).map {'.'}

      lookup[y]&.each do |l|
        row[l.x - minx] = "#"
      end

      row
    end.each do |row|
      puts row.join('')
    end
  end

  attr_reader :lights
end

Board.new(File.open('10.txt')).run!

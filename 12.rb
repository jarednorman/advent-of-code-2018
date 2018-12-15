#!/usr/bin/env ruby
require_relative 'bootstrap'

INITIAL_STATE = "##.###.......#..#.##..#####...#...#######....##.##.##.##..#.#.##########...##.##..##.##...####..####"

INPUT = {
  '#.#.#' => '#',
  '.##..' => '.',
  '#.#..' => '.',
  '..###' => '#',
  '.#..#' => '#',
  '..#..' => '.',
  '####.' => '#',
  '###..' => '#',
  '#....' => '.',
  '.#.#.' => '#',
  '....#' => '.',
  '#...#' => '#',
  '..#.#' => '#',
  '#..#.' => '#',
  '.#...' => '#',
  '##..#' => '.',
  '##...' => '.',
  '#..##' => '.',
  '.#.##' => '#',
  '.##.#' => '.',
  '#.##.' => '#',
  '.####' => '.',
  '.###.' => '.',
  '..##.' => '.',
  '##.#.' => '.',
  '...##' => '#',
  '...#.' => '.',
  '.....' => '.',
  '##.##' => '.',
  '###.#' => '#',
  '#####' => '#',
  '#.###' => '.'
}

class PartOne
  def initialize(initial_state, input)
    @state = initial_state
    @input = input
    @extras = 0
  end

  attr_reader :input
  attr_accessor :state

  def answer
    20.times { step! }

    state.split('').each_with_index.sum do |c, i|
      if c == "#"
        i - @extras
      else
        0
      end
    end
  end

  def step!
    @extras += 2
    letters = ['.', '.'] + state.split('') + ['.', '.']
    self.state = letters.each_with_index.map do |c, i|
      a = if i - 2 >= 0 then letters[i - 2] else '.' end
      b = if i - 1 >= 0 then letters[i - 1] else '.' end
      d = letters[i + 1] || '.'
      e = letters[i + 2] || '.'

      input[[a, b, c, d, e].join] || '.'
    end.join
  end
end

test = PartOne.new(
  "#..#.#..##......###...###",
  {
    '...##' => '#',
    '..#..' => '#',
    '.#...' => '#',
    '.#.#.' => '#',
    '.#.##' => '#',
    '.##..' => '#',
    '.####' => '#',
    '#.#.#' => '#',
    '#.###' => '#',
    '##.#.' => '#',
    '##.##' => '#',
    '###..' => '#',
    '###.#' => '#',
    '####.' => '#'
  }
)
#test.step!
#puts test.state
#19.times { test.step! }
#puts test.state

puts "Part One: #{PartOne.new(INITIAL_STATE, INPUT).answer}"

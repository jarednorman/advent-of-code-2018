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
    @offset = 0
    @states = Set.new
  end

  attr_reader :input
  attr_accessor :state

  def answer(n)
    n.times.each do |n|
      puts n if n % 1000 == 0
      step!
    end

    state.split('').each_with_index.sum do |c, i|
      if c == "#"
        i - @offset
      else
        0
      end
    end
  end

  def step!
    if state == "#....#....#........#....#................#.....#....#....#....#........#.....#.........#.....#.....#....#.....#.....#......#....#.....#....#.......#"
      @offset -= 1
    else
      @offset += 2
      letters = ['.', '.'] + state.split('') + ['.', '.']
      self.state = letters.each_with_index.map do |c, i|
        a = if i - 2 >= 0 then letters[i - 2] else '.' end
        b = if i - 1 >= 0 then letters[i - 1] else '.' end
        d = letters[i + 1] || '.'
        e = letters[i + 2] || '.'

        input[[a, b, c, d, e].join] || '.'
      end.join

      while state[0] == '.'
        @offset -= 1
        self.state = state.slice(1, state.length - 1)
      end

      while state[-1] == '.'
        self.state = state.slice(0, state.length - 1)
      end
    end
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
#puts test.state
#test.step!
#puts test.state
#test.step!
#puts test.state
#test.step!
#puts test.state
#test.step!
#puts test.state
#19.times { test.step! }
#puts test.state

one = PartOne.new(INITIAL_STATE, INPUT).answer(20)
raise one.to_s unless one == 1430
puts "Part One: #{one}"
puts "Part Two: #{PartOne.new(INITIAL_STATE, INPUT).answer(50000000000)}"

#!/usr/bin/env ruby
require_relative 'bootstrap'

INPUT = File.open('08.txt').read.chomp.split(' ').map(&:to_i)

class Problem
  def initialize(input)
    @input = input.dup
  end

  attr_reader :input
end

class Node
  def initialize(list)
    child_count = list.shift
    metadata_count = list.shift

    @children = child_count.times.map { Node.new(list) }
    @metadata = metadata_count.times.map { list.shift }
  end

  attr_reader :children
  attr_reader :metadata

  def flatten
    [self] + children.flat_map(&:flatten)
  end

  def value
    if children.empty?
      metadata.sum
    else
      metadata.sum do |m|
        next 0 if m == 0
        child = children[m - 1]
        next child.value if child
        0
      end
    end
  end
end

class PartOne < Problem
  def answer
    tree = Node.new(input)

    all_nodes = tree.flatten

    all_nodes.flat_map(&:metadata).sum
  end
end

puts "Part One: #{PartOne.new(INPUT).answer}"

class PartTwo < Problem
  def answer
    root = Node.new(input)
    root.value
  end
end

puts "Part Two: #{PartTwo.new(INPUT).answer}"

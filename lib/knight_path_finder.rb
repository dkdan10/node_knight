require_relative "00_tree_node.rb"
require "byebug"
def check_range(x, y)
  range = (0...8).to_a
  range.include?(x) && range.include?(y)
end

class KnightPathFinder

  attr_accessor :considered_positions
  attr_reader :start_pos

  def initialize(start_pos)
    start_pos = start_pos.split(",").map(&:to_i) if !start_pos.is_a?(Array)
    @start_pos = start_pos
    @considered_positions = [start_pos]

    build_move_tree
  end

  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos)
      .select {|opt_pos| !@considered_positions.include?(opt_pos)}
      .each {|new_pos| @considered_positions << new_pos}
  end

  def self.valid_moves(pos)
    possible_moves = []
    possible_moves << [pos[0] + 1, pos[1] + 2] if check_range(pos[0] + 1, pos[1] + 2) 
    possible_moves << [pos[0] + 2, pos[1] + 1] if check_range(pos[0] + 2, pos[1] + 1)  
    possible_moves << [pos[0] - 1, pos[1] + 2] if check_range(pos[0] - 1, pos[1] + 2)  
    possible_moves << [pos[0] - 1, pos[1] + 1] if check_range(pos[0] - 1, pos[1] + 1)  
    possible_moves << [pos[0] + 1, pos[1] - 2] if check_range(pos[0] + 1, pos[1] - 2)  
    possible_moves << [pos[0] + 2, pos[1] - 1] if check_range(pos[0] + 2, pos[1] - 1)  
    possible_moves << [pos[0] - 1, pos[1] - 2] if check_range(pos[0] - 1, pos[1] - 2)  
    possible_moves << [pos[0] - 2, pos[1] - 1] if check_range(pos[0] - 2, pos[1] - 1)  

    possible_moves
  end

  def build_move_tree
    root_tree = PolyTreeNode.new(start_pos)
    queue = [root_tree]
    while !queue.empty?
      # debugger
      parent = queue.shift
      new_move_positions(parent.value).each do |new_pos|
        # @considered_positions += [parent.value]
        new_leaf = PolyTreeNode.new(new_pos)
        new_leaf.parent = parent
        queue << new_leaf
      end
    end
    root_tree
  end
end

knight = KnightPathFinder.new([0,1])

p knight.considered_positions.count
p knight.considered_positions.uniq.count
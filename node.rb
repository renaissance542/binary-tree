# frozen_string_literal: true

# nodes for binary tree
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def <=>(other)
    return nil unless other.is_a? Numeric

    self <=> other
  end

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

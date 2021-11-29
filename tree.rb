# frozen_string_literal: true

require_relative 'node'
require 'pry-byebug'
# binary tree class
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.sort!.tap(&:uniq!), 0, (arr.size - 1))
  end

  def build_tree(arr, first, last)
    return nil if first > last

    mid = (first + last) / 2
    node = Node.new(arr[mid])
    node.left = build_tree(arr, first, mid - 1)
    node.right = build_tree(arr, mid + 1, last)
    node
  end

  def insert(value)
    insert_leaf(@root, value)
  end

  def delete(data)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private
  
  # rubocop:disable Metrics/MethodLength
  def insert_leaf(node, value)
    return if value == node.data

    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
      else
        insert_leaf(node.left, value)
      end
    else
      if node.right.nil?
        node.right = Node.new(value)
      else
        insert_leaf(node.right, value)
      end
    end
  end
end

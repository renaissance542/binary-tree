# frozen_string_literal: true

require_relative 'node'
require 'pry-byebug'

# rubocop:disable Metric/ClassLength

# binary tree class
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.sort!.tap(&:uniq!), 0, (arr.size - 1))
  end

  def build_tree(arr, first = 0, last = arr.size - 1)
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

  def delete(value)
    find_target_nodes(value)
    return if @target.nil?

    case count_children(@target)
    when 0
      delete_target_no_child
    when 1
      delete_target_one_child
    when 2
      delete_target_two_childs
    end
  end

  def find(value, node = @root)
    return node if node.nil? || node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order(nodes = [@root], &block)
    return to_a unless block_given? # array of values

    node = nodes.shift
    nodes.push node.left unless node.left.nil?
    nodes.push node.right unless node.right.nil?
    yield node
    level_order(nodes, &block) unless nodes.empty?
  end

  def inorder(node = @root, &block)
    return to_a unless block_given? # array of values

    inorder(node.left, &block) unless node.left.nil?
    yield node
    inorder(node.right, &block) unless node.right.nil?
  end

  def preorder(node = @root, &block)
    return to_a unless block_given? # array of values

    yield node
    preorder(node.left, &block) unless node.left.nil?
    preorder(node.right, &block) unless node.right.nil?
  end

  def postorder(node = @root, &block)
    return to_a unless block_given? # array of values

    postorder(node.left, &block) unless node.left.nil?
    postorder(node.right, &block) unless node.right.nil?
    yield node
  end

  # return array of all values in the tree
  def to_a(node = @root)
    arr = []
    arr += to_a(node.left) unless node.left.nil?
    arr += [node.data]
    arr += to_a(node.right) unless node.right.nil?
    arr
  end

  # accepts a node and returns its height
  def height(node = @root)
    return -1 if node.nil?

    1 + [height(node.left), height(node.right)].max
  end

  # accepts a node and returns its depth
  def depth(node)
    return height unless node

    current = @root
    depth = 0
    while current.data != node.data && current
      depth += 1
      current = node.data < current.data ? current.left : current.right
    end
    depth
  end

  # left and right subtrees have height difference of 1 or less
  # and left and right subtrees are also balanced
  def balanced?(node = @root)
    return true if node.nil?

    bal = (height(node.left) - height(node.right)).between?(-1, 1)
    balanced?(node.left) && balanced?(node.right) && bal
  end

  def rebalance
    @root = build_tree(to_a)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def count_children(node)
    children = 2
    children -= 1 if node.left.nil?
    children -= 1 if node.right.nil?
    children
  end

  def delete_target_no_child
    if @target.data < @parent.data
      @parent.left = nil
    else
      @parent.right = nil
    end
  end

  # attach the deleted node's child to the correct position on the parent
  def delete_target_one_child
    if @parent.nil?
      @root = @target.left.nil? ? @target.right : @target.left
    elsif @target.data < @parent.data
      @parent.left = @target.left.nil? ? @target.right : @target.left
    else
      @parent.right = @target.left.nil? ? @target.right : @target.left
    end
  end

  def delete_target_two_childs
    find_inorder_nodes
    fix_parent_children
    @inorderparent.left = @inorder.right unless @inorderparent == @target
    @inorder.left = @target.left
    @inorder.right = @target.right unless @inorderparent == @target
  end

  def fix_parent_children
    if @parent.nil?
      @root = @inorder
    elsif @target.data < @parent.data
      @parent.left = @inorder
    else
      @parent.right = @inorder
    end
  end

  def find_target_nodes(value)
    @parent = nil
    @target = @root
    while @target.data != value && !@target.nil?
      @parent = @target
      @target = next_child(value)
    end
  end

  def find_inorder_nodes
    @inorderparent = @target
    @inorder = @target.right
    until @inorder.left.nil?
      @inorderparent = @inorder
      @inorder = @inorder.left
    end
  end

  def next_child(value)
    value < @target.data ? @target.left : @target.right
  end

  # rubocop:disable Metrics/MethodLength
  def insert_leaf(node, value)
    return if value == node.data

    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
      else
        insert_leaf(node.left, value)
      end
    elsif node.right.nil?
      node.right = Node.new(value)
    else
      insert_leaf(node.right, value)
    end
  end
  # rubocop:enable Metrics/MethodLength
end

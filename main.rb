# frozen_string_literal: true

require_relative 'tree'

system("clear") || system("cls")

# arr = []
# 20.times { arr.push rand 50 }

arr = [0, 13, 15, 19, 21, 27, 30, 31, 32, 34, 35, 39, 40, 42, 45, 47, 48, 49, 50, 51, 52]

p arr.sort

tree = Tree.new(arr)
# tree.pretty_print

puts "\n*********************\n\n"
tree.insert(27)
tree.insert(50)
tree.insert(51)
tree.insert(52)
tree.pretty_print

# p tree.find(27)
# puts "\n*********************\n\n"
# tree.delete(27)
# tree.pretty_print

p tree.to_a

# puts "\nlevel_order { |n| puts n.data }"
# tree.level_order { |n| puts n.data }

# puts "\nlevel_order"
# p tree.level_order

# puts "\ninorder { |n| p n.data }"
# tree.inorder { |n| p n.data }

# puts "\nprenorder { |n| p n.data }"
# tree.preorder { |n| p n.data }

# puts "\npostorder { |n| p n.data }"
# tree.postorder { |n| p n.data }

puts "\ntree.height"
p tree.height

puts "\ntree.height(tree.root.left)"
p tree.height(tree.root.left)

puts "\ntree.height(tree.find(27))"
p tree.height(tree.find(27))

puts "\ntree.depth(tree.find(27))"
p tree.depth(tree.find(27))

puts "\ntree.height(tree.find(47))"
p tree.height(tree.find(47))

puts "\ntree.depth(tree.find(47))"
p tree.depth(tree.find(47))

puts "\ntree.height(tree.find(46)) *missing node*"
p tree.height(tree.find(46))

puts "\ntree.depth(tree.find(46)) *missing node*"
p tree.depth(tree.find(46))
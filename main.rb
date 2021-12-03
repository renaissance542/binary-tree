# frozen_string_literal: true

require_relative 'tree'

system("clear") || system("cls")

arr = Array.new(15) { rand(1..100) }
puts "seed array = #{arr}\n"

tree = Tree.new(arr)
tree.pretty_print

puts "\nTree balanced? : #{tree.balanced?}"
p tree.balanced?

puts "\nlevel_order { |n| puts n.data }"
tree.level_order { |n| puts n.data }

puts "\nprenorder { |n| p n.data }"
tree.preorder { |n| p n.data }

puts "\npostorder { |n| p n.data }"
tree.postorder { |n| p n.data }

puts "\ninorder { |n| p n.data }"
tree.inorder { |n| p n.data }

puts "\n*********************\n\n"
puts "inserting 101, 104, 108"
tree.insert(101)
tree.insert(104)
tree.insert(108)

tree.pretty_print
puts "\nTree balanced? : #{tree.balanced?}"

puts "\nRebalancing tree"
tree.rebalance

puts "\nTree balanced? : #{tree.balanced?}"

tree.pretty_print

puts "\nlevel_order { |n| puts n.data }"
tree.level_order { |n| puts n.data }

puts "\nprenorder { |n| p n.data }"
tree.preorder { |n| p n.data }

puts "\npostorder { |n| p n.data }"
tree.postorder { |n| p n.data }

puts "\ninorder { |n| p n.data }"
tree.inorder { |n| p n.data }

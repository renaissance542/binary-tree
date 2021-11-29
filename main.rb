# frozen_string_literal: true

require_relative 'tree'

system("clear") || system("cls")

arr = []
10.times { arr.push rand 100 }
p arr.sort

tree = Tree.new(arr)
tree.pretty_print

puts "\n*********************\n\n"
tree.insert(40)
tree.pretty_print


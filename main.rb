require_relative 'lib/node'
require_relative 'lib/bst'
require_relative 'lib/tree'

bst = BinaryTree.new

20.times do 
  k = rand(200)
  bst.insert(k) 
end
sep = '='*40
ls = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 33, 23, 13, 11, 12]
tree = Tree.new(ls)
tree.pretty_print
puts sep

puts 'inserting 999'
tree.insert(999)
tree.pretty_print
puts sep

puts 'deleting 33'
tree.delete(33)
tree.pretty_print
puts sep

puts 'deleting root (11)'
tree.delete(11)
tree.pretty_print
puts sep

puts 'deleting 999'
tree.delete(999)
tree.pretty_print
puts sep

puts 'let us try to delete something non present like 9999'
tree.delete(9999)
tree.pretty_print
puts sep

puts 'searching for 999'
p tree.find(999)
puts sep

puts 'searching for 8'
puts tree.find(8)
puts sep
# bst.pretty_print()
# pretty_print(bst)

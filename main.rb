require_relative 'lib/node'
# require_relative 'lib/bst'
require_relative 'lib/tree'

# bst = BinaryTree.new

# 20.times do 
#   k = rand(200)
#   bst.insert(k) 
# end

sep = '=' * 40
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

puts 'Testing #level_order'
p tree.level_order # { |x| puts x }
puts sep

puts 'Testing #in_order'
p tree.in_order # { |x| puts x }
puts sep

puts 'Testing #pre_order'
p tree.pre_order # { |x| puts x }
puts sep

puts 'Testing #post_order'
p tree.post_order # { |x| puts x }
puts sep

puts 'What is the #hight of the tree?'
p tree.height # { |x| puts x }
puts sep

node = tree.root.left.right
puts "What is the #depth of the #{node.data}?"
p tree.depth(node) # { |x| puts x }
puts sep

puts 'Is our tree #balanced?'
p tree.balanced? # { |x| puts x }
puts sep


puts "Now, let's change some values"
tree.insert(99)
tree.insert(98)
tree.delete(6345)
tree.pretty_print
puts 'Is it still #balanced?'
p tree.balanced? # { |x| puts x }
puts sep
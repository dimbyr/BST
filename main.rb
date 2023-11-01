require_relative 'lib/node'
require_relative 'lib/bst'
require_relative 'lib/tree'

bst = BinaryTree.new

20.times do 
  k = rand(200)
  bst.insert(k) 
end

ls = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 33, 23, 13, 11, 12]
tree = Tree.new(ls)
tree.insert(999)
tree.delete(3)
tree.pretty_print
# bst.pretty_print()
# pretty_print(bst)

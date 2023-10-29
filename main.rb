require_relative 'lib/node'
require_relative 'lib/bst'

bst = Tree.new

20.times do 
  k = rand(200)
  bst.insert(k) 
end

bst.pretty_print()
# pretty_print(bst)

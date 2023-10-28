require_relative 'lib/node'
require_relative 'lib/bst'

bst = Tree.new

(20..30).each { |k| bst.insert(k) }

(10..20).reverse_each { |k| bst.insert(k) }

p bst

require_relative 'lib/node'
require_relative 'lib/bst'

# def pretty_print(node = @root, prefix = '', is_left: false)
#   pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
#   puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
#   pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
# end

bst = Tree.new

(20..30).each { |k| bst.insert(k) }

(10..20).reverse_each { |k| bst.insert(k) }

p bst
# pretty_print(bst)

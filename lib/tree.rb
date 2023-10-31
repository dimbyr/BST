require_relative 'node'

# This class build a balanced binary search tree from a list
class Tree 
  attr_accessor :root 

  def initialize(list)
    @root = build_tree(list.uniq.sort)
  end

  def build_tree(lst)
    n = lst.length
    return nil if lst.nil? || n.zero?
    return Node.new(lst[0]) if n == 1

    halflen = n/2
    root = Node.new(lst[halflen])
    left_half = lst[...halflen]
    right_half = lst[(halflen + 1)..]
    root.left = build_tree(left_half)
    root.right = build_tree(right_half)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

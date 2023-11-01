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

  def insert(value, node = @root)
    if node.data.nil?
      node.data = value
    elsif node.left.nil? && value < node.data 
      node.left = Node.new(value)
    elsif node.right.nil? && value >= node.data
      node.right = Node.new(value)
    elsif value < node.data 
      insert(value, node.left)
    elsif value >= node.data
      insert(value, node.right)
    end
  end

  def delete(value)
    node = @root
    node = node.data >= value ? node.left : node.right until node.nil? || node.a_leaf? || node.data == value
    return if node.nil?
    
    if node.two_children?
      replacement = node.right
      replacement = replacement.left until replacement.only_right_child? || replacement.a_leaf?
      node.data = replacement.data
      delete(replacement.data)
    elsif node.a_leaf?
      node = nil
    elsif node.only_left_child?
      node = node.left
    else
      node = node.right
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

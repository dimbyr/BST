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

  def delete(value, node = @root)
    node = walk_to_parent_of(value, node)
    return if node.nil? || node.a_leaf?

    if node.data == value
      lub = smallest(node.right)
      delete(lub, node.right)
      node.data = lub
    elsif node.child_data?(value)
      target_node = node.left_data?(value) ? node.left : node.right
      if target_node.a_leaf? 
        node.left = nil if node.left_data?(value)
        node.right = nil if node.right_data?(value)
      elsif target_node.only_left_child? || target_node.only_right_child?
        upd = delete_single_child(target_node)
        node.left = upd if node.left_data(value)
        node.right = upd if node.right_data(value)
      else
        lub = smallest(target_node.right)
        delete(lub)
        node.left.data = lub if node.left_data?(value)
        node.right.data = lub if node.right_data?(value)
      end
    end
  end

  def delete_single_child(node)
    node.only_left_child? ? node.left : node.right
  end

  def smallest(node)
    node = node.left until node.left.nil?
    node.data
  end

  def walk_to_parent_of(value, node)
    until node.nil? || node.a_leaf? || node.data == value || node.child_data?(value)
      node = value < node.data ? node.left : node.right
    end
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

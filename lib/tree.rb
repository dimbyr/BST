require_relative 'node'

# This collects all the tools to delete a value from a tree
module Deletable
  def delete_root(node)
    lub = smallest(node.right)
    delete(lub, node.right)
    node.data = lub
  end

  def delete_child(node, value)
    target_node = node.left_data?(value) ? node.left : node.right
    if target_node.a_leaf?
      delete_leaf(node, value)
    elsif target_node.only_left_child? || target_node.only_right_child?
      delete_single_child(node, value)
    else
      delete_node_with_two_children(node, target_node, value)
    end
  end

  def delete_node_with_two_children(node, target_node, value)
    lub = smallest(target_node.right)
    delete(lub)
    node.left.data = lub if node.left_data?(value)
    node.right.data = lub if node.right_data?(value)
  end

  def delete_single_child(node, value)
    upd = node.only_left_child? ? node.left : node.right
    node.left = upd if node.left_data(value)
    node.right = upd if node.right_data(value)
  end

  def delete_leaf(node, value)
    node.left = nil if node.left_data?(value)
    node.right = nil if node.right_data?(value)
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
end

# Tools for inserting a velue in a tree
module Insertable
  def insert_value(value, node)
    if !node.two_children?
      insert_when_atleast_one_child_nil(value, node)
    elsif value < node.data
      insert_value(value, node.left)
    elsif value >= node.data
      insert_value(value, node.right)
    end
  end

  def insert_when_atleast_one_child_nil(value, node)
    if node.data.nil?
      insert_if_data_nil(value, node)
    elsif node.left.nil? && value < node.data 
      insert_left(value, node)
    elsif node.right.nil? && value >= node.data
      insert_right(value, node)
    end
  end

  def insert_if_data_nil(value, node)
    node.data = value
  end

  def insert_left(value, node)
    node.left = Node.new(value)
  end

  def insert_right(value, node)
    node.right = Node.new(value)
  end
end

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

    root, left_half, right_half = halves(lst)
    root.left = build_tree(left_half)
    root.right = build_tree(right_half)
    root
  end

  def insert(value, node = @root)
    insert_value(value, node)
  end

  def delete(value, node = @root)
    return if find(value).nil?

    node = walk_to_parent_of(value, node)
    if node.data == value
      delete_root(node)
    elsif node.child_data?(value)
      delete_child(node, value)
    end
  end

  def find(value)
    node = @root
    node = value < node.data ? node.left : node.right until node.nil? || node.data == value
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  include Deletable
  include Insertable

  def halves(lst)
    halflen = lst.length / 2
    left_half = lst[...halflen]
    right_half = lst[(halflen + 1)..]
    root = Node.new(lst[halflen])
    [root, left_half, right_half]
  end
end

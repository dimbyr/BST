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

# Tree traversal methods
module Traversable
  def level_order(node = @root)
    q = []
    res = []
    q << node if node
    until q.empty?
      data = enqueue(q.first, q)
      block_given? ? (yield data) : (res << data)
      q.shift
    end
    res unless block_given?
  end

  def in_order(node = @root)
    return if node.nil?

    data = node.data
    in_order(node.left) if node.left
    block_given? ? (yield data) : (@in_order_list << data)
    in_order(node.right) if node.right
    @in_order_list unless block_given?
  end

  def pre_order(node = @root)
    return if node.nil?

    data = node.data
    block_given? ? (yield data) : (@pre_order_list << data)
    pre_order(node.left) if node.left
    pre_order(node.right) if node.right
    @pre_order_list unless block_given?
  end

  def post_order(node = @root)
    return if node.nil?

    data = node.data
    post_order(node.left) if node.left
    post_order(node.right) if node.right
    block_given? ? (yield data) : (@post_order_list << data)
    @post_order_list unless block_given?
  end
end

# This class build a balanced binary search tree from a list
class Tree
  attr_accessor :root, :in_order_list, :pre_order_list, :post_order_list

  def initialize(list)
    @root = build_tree(list.uniq.sort)
    @in_order_list = []
    @pre_order_list = []
    @post_order_list = []
  end

  include Deletable
  include Insertable
  include Traversable

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
    # check this method again? it seems to fail adding successive numbers 
    # like 99, 98, 97 ? strange
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

  def height(node = @root)
    return 0 if node.nil?

    left_hight = height(node.left)
    right_hight = height(node.right)
    1 + [left_hight, right_hight].max
  end

  def depth(node)
    d = 0
    start = @root
    value = node.data
    until start.nil? || start.data == value
      start = value < start.data ? start.left : start.right 
      d += 1
    end
    start.nil? ? 'Not found' : d
  end

  def balanced?(node = @root)
    return true if node.nil?

    left = node.left
    right = node.right
    left_hight = height(left)
    right_hight = height(right)
    return false if (left_hight - right_hight).abs > 1

    true && balanced?(left) && balanced?(right)
  end

  def rebalance
    new_list = level_order(@root).sort
    @root = build_tree(new_list)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def halves(lst)
    halflen = lst.length / 2
    left_half = lst[...halflen]
    right_half = lst[(halflen + 1)..]
    root = Node.new(lst[halflen])
    [root, left_half, right_half]
  end

  def enqueue(current_node, queue)
    left = current_node.left
    right = current_node.right
    queue << left if left
    queue << right if right
    current_node.data
  end
end

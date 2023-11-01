# A node of a binary tree
class Node
  attr_accessor :data, :left, :right

  def initialize(value = nil, left = nil, right = nil)
    @data = value
    @left = left
    @right = right
  end

  def a_leaf?
    @left.nil? && @right.nil?
  end

  def only_left_child?
    @right.nil? && @left
  end

  def only_right_child?
    @left.nil? && @right
  end

  def two_children?
    @left && @right
  end

  def child_data?(value)
    if two_children?
      @left.data == value || @right.data == value
    elsif only_left_child?
      @left.data == value
    elsif only_right_child?
      @right.data == value
    else
      false
    end
  end
end

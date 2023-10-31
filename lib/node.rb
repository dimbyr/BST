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
end

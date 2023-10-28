require_relative 'node'

class Tree 
  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def insert(value)
    current_node = @root
    if current_node.data.nil?
      @root.data = value
    else
      until current_node.left.nil? || current_node.right.nil?
        current_node = current_node.left until current_node.left.nil? || current_node.data < value
        current_node = current_node.right until current_node.right.nil? || current_node.data >= value
      end
      current_node.left = Node.new(value) if current_node.left.nil? && current_node.data >= value
      current_node.right = Node.new(value) if current_node.right.nil? && current_node.data < value
    end
  end
end

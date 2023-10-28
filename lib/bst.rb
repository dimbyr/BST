require_relative 'node'

class Tree 
  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def insert(value)
    current_node = @root
    if current_node.value.nil?
      @root.value = value
    else
      until current_node.left.nil? || current_node.right.nil?
        current_node = current_node.left until current_node.left.nil? || current_node.value < value
        current_node = current_node.right until current_node.right.nil? || current_node.value >= value
      end
      current_node.left = Node.new(value) if current_node.left.nil? && current_node.value >= value
      current_node.right = Node.new(value) if current_node.right.nil? && current_node.value < value
    end
  end
end

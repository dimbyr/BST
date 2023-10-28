class Node 
  attr_accessor :data, :left, :right

  def initialize(value = nil, left = nil, right = nil)
    @data = value
    @left = left
    @right = right
  end
end

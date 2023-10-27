require_relative 'node'

class Tree 
  attr_accessor :root

  def initialize
    @root = Node.new
  end

end

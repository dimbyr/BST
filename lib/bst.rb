require_relative 'node'

class Tree 
  attr_accessor :root

  def initialize
    @root = Node.new
  end

  def build_tree(list)
    l = list.sort.uniq
    n = l.length
    return 'Empty list' if l.empty?
    if l.length == 1
      insert(l[0])
    else
      l1 = l[0...(n/2)] 
      l2 = l[(n/2)...n]
      # mbola ts vita ti
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

  def pretty_print(node = @root, prefix = '', is_left= false)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

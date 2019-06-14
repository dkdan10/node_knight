class PolyTreeNode

  attr_accessor :value, :parent, :children

  def initialize(value)
    @value = value 
    @parent = nil
    @children = []
  end 

  def parent=(node)
    # debugger
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self 
    end 
    

  end

  def add_child(node)
    node.parent= self
  end
  
  def remove_child(node)
    raise "not a child." if !@children.include?(node)
    node.parent = nil
  end 


  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child_n|
      val = child_n.dfs(target_value)
      return val if val 
    end
    nil
  end 

  def bfs(target_value)
    queue = []
    queue << self
    while !queue.empty?
      check_node = queue.shift
      return check_node if check_node.value == target_value
      queue += check_node.children
    end
    nil
  end

end

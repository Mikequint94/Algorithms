class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  def initialize
    @list = []
    @head = Node.new
    @tail = Node.new
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @list[0]
  end

  def last
    @list[-1]
  end

  def empty?
    @list.length == 0
  end

  def get(key)
    @list.each do |node|
      if node.key = key
        return node
      end
    end
  end

  def include?(key)
  end

  def append(key, val)
    @list << Node.new(key, val)
    @list[-1].prev = @list[-2] || @head
    @list[-2].next = @list[-1] if @list[-2]
    @list [-1].next = @tail
  end

  def update(key, val)
    @list.each do |node|
      if node.key = key
        node.val = val
      end
    end
  end

  def remove(key)
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end

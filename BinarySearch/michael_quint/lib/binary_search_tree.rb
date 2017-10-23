# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'
class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    newnode = BSTNode.new(value)
    inserted = false
    if @root
      search_item = @root
      until inserted
        if newnode.value <= search_item.value
          if search_item.left
            search_item = search_item.left
          else
            search_item.left = newnode
            newnode.parent = search_item
            inserted = true
          end
        else
          if search_item.right
            search_item = search_item.right
          else
            search_item.right = newnode
            newnode.parent = search_item
            inserted = true
          end
        end
      end
    else
      @root = newnode
      newnode.parent = nil
    end
    return newnode
  end

  def find(value, tree_node = @root)
    found = false
    search_item = tree_node
    until found
      return nil unless search_item
      if search_item.value == value
        found = true
      elsif search_item.value >= value
        search_item = search_item.left
      else
        search_item = search_item.right
      end
    end
    return search_item
  end

  def delete(value)
    target = find(value)
    # p target
    if target.parent == nil # if target is root
      @root = nil
      return @root
    elsif !target.left && !target.right # if target has no children
      target.parent.left = nil if target.parent.value >= value
      target.parent.right = nil if target.parent.value < value
      # return target
    elsif (target.left && !target.right) || (target.right && !target.left) #1child
      child = target.left || target.right
      target.parent.left = child if target.parent.value >= value
      target.parent.right = child if target.parent.value < value
      # return child
    else #target has 2 children
      replacement = maximum(target.left)
      replacement2 = replacement

      target.left.parent = replacement
      target.right.parent = replacement
      target.parent.left = replacement if target.parent.value >= value
      target.parent.right = replacement if target.parent.value < value
      if replacement.left
        replacement.left.parent = replacement2.parent
        replacement.parent.right = replacement2.left
      end
    end
  end
  # helper method for #delete:
  def maximum(tree_node = @root)
    maxval = tree_node.value
    finished = false
    search_item = tree_node
    until finished
      if search_item.right
        if search_item.right.value > maxval
          maxnode = search_item.right
          maxval = maxnode.value
        end
        search_item = search_item.right
      else
        finished = true
      end
    end
    return maxnode
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil? || (tree_node.left.nil? && tree_node.right.nil?)
    return 1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil? || (tree_node.left.nil? && tree_node.right.nil?)
    return false if (depth(tree_node.right) - depth(tree_node.left)).abs > 1
    [is_balanced?(tree_node.left), is_balanced?(tree_node.right)].all?
  end

  def in_order_traversal(tree_node = @root, arr = [])

   in_order_traversal(tree_node.left, arr) if tree_node.left
   arr << tree_node.value
   in_order_traversal(tree_node.right, arr) if tree_node.right
   return arr

  end

  def self.size(tree_node = @root)
    return 0 if tree_node.nil?
    1 + size(tree_node.left) + size(tree_node.right)
  end

end

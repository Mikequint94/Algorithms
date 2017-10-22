require 'binary_search_tree'

def kth_largest(tree_node, k)
  if BinarySearchTree.size(tree_node.right) == k-1
    return tree_node
  elsif BinarySearchTree.size(tree_node.right) >=k
    kth_largest(tree_node.right, k)
  else
    kth_largest(tree_node.left, (k- BinarySearchTree.size(tree_node.right) -1))
  end
end

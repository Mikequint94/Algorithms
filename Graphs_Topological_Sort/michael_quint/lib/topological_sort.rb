require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices) # Kahn's Algorithm
  sorted = []
  top_queue = []
  in_edge_count = Hash.new(0)
  vertices.each do |vertex|
    in_edge_count[vertex] = vertex.in_edges.length
    top_queue.unshift(vertex) if vertex.in_edges.empty?
  end
  until top_queue.empty?
    # debugger
    current = top_queue.pop
    sorted << current
    current.out_edges.each do |edge|
      top_queue.unshift(edge.to_vertex) if in_edge_count[edge.to_vertex] <= 1
      in_edge_count[edge.to_vertex] -= 1
    end
    # current.destroy!

  end
  if sorted.length == vertices.length
    return sorted
  else
    return []
  end
end

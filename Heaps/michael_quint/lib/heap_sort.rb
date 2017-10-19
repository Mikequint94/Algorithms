require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new(Proc.new { |el1, el2| (el1 <=> el2) })
  end
end

require_relative "heap"

class Array
  def heap_sort!

    prc = Proc.new { |el1, el2| (el1 <=> el2) }
    heap = BinaryMinHeap.new(&prc)
    self.each do |num|
      heap.push(num)
    end

    length.times do |idx|
      self[idx] = heap.extract
    end

    self
  end
end

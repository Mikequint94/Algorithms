require_relative 'heap'

def k_largest_elements(array, k)

    prc = Proc.new { |el1, el2| (el2 <=> el1) }
    heap = BinaryMinHeap.new(&prc)

    array.each do |num|
      heap.push(num)
    end

    array.length.times do |idx|
      array[idx] = heap.extract
    end
    results = array
    return results[(array.length-k)..-1]
end

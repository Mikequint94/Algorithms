class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    #pop. returns min val and extracts it
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    extracted
  end

  def peek
    #constant time, shows min or max
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count)
  end

  public
  def self.child_indices(len, parent_index)
    child1idx = parent_index*2 + 1
    child2idx = parent_index*2 + 2
    case len <=> parent_index*2 + 2
    when -1
      return []
    when 0
      return [child1idx]
    when 1
      return [child1idx, child2idx]
    end
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    ((child_index -1) /2)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| (el1 <=> el2) }
    parent = array[parent_idx]
    child1 = child_indices(len, parent_idx)[0] || nil
    child2 = child_indices(len, parent_idx)[1] || nil
      if ((child1 && prc.call(parent, array[child1]) == 1) || (child2 && prc.call(parent, array[child2]) == 1))
        if child2
          swap_child = prc.call(array[child1], array[child2]) < 1 ? child1 : child2
        else
          swap_child = child1
        end
        # swap_child = child2 if array[child1] > array[child2]
        array[parent_idx], array[swap_child] = array[swap_child], array[parent_idx]
        self.heapify_down(array, swap_child, len, &prc)
      end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| (el1 <=> el2) }
    child = array[child_idx]
    return array if child_idx == 0
      parent_idx = parent_index(child_idx)
      if (prc.call(child, array[parent_idx]) == -1)
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        self.heapify_up(array, parent_idx, len, &prc)
      end
    array
  end
end

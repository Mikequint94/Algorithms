class Array

  def partition(start, length)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    pivot_idx = start
    pivot = self[start]

    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, self[idx]) > 0
        self[idx], self[pivot_idx + 1] = self[pivot_idx + 1], self[idx]
        pivot_idx += 1
      end
    end
    self[start], self[pivot_idx] = self[pivot_idx], self[start]

    pivot_idx
  end

  def select_kth_smallest(k)

    return nil if length < k
    return self if length < 2

    pivot_idx = partition(0, self.length)
    case pivot_idx <=> (k-1)
    when 0
      return self[pivot_idx]
    when -1
      self.slice(pivot_idx + 1.. -1)
      select_kth_smallest(k-pivot_idx)
    when 1
      self.slice(0...pivot_idx)
      select_kth_smallest(k)
    end
  end
end

arr = [1,4,2,5,3,5]
p arr.select_kth_smallest(1)
p arr.select_kth_smallest(2)
p arr.select_kth_smallest(3)
p arr.select_kth_smallest(4)
p arr.select_kth_smallest(5)
p arr.select_kth_smallest(6)

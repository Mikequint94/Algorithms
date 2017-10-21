require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []
    array[1..-1].each do |el|
      case el <=> pivot
      when -1 || 0
        left << el
      when 1
        right << el
      end
    end
    return self.sort1(left) + [pivot] + self.sort1(right)

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    # debugger
    prc = prc || Proc.new {|el1, el2| el1 <=> el2}

    return array if length <= 1
    # pivot = array[rand(start...length)]
    pivot_idx = partition(array, start, length, &prc)

    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, (length - (pivot_idx + 1) + start), &prc)

    return array
  end

  def self.partition(array, start, length, &prc)
    prc = prc || Proc.new {|el1, el2| el1 <=> el2}
    
    pivot_idx = start
    pivot = array[start]

    ((start+1)...(start+length)).each do |idx|
      val = array[idx]
      if prc.call(val, pivot) == -1
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = val
        pivot_idx += 1
      end
    end

    pivot_idx

  end
end

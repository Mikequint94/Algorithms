require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if index >= @length
      raise "index out of bounds"
    else
      @store[(index + @start_idx) % @capacity]
    end
  end

  # O(1)
  def []=(index, val)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    lastidx = (@length  + @start_idx - 1) % @capacity
    popped = @store[lastidx]
    @store[lastidx] = nil
    @length -=1
    return popped
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
    end
    @store[(@length + @start_idx ) % @capacity] = val
    @length += 1
    p @store
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    # lastidx = (@length  + @start_idx - 1) % @capacity
    shifted = @store[@start_idx % @capacity]
    @store[@start_idx % @capacity] = nil
    @length -=1
    @start_idx +=1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
    end
    # lastidx = (@length  + @start_idx - 1) % @capacity
    # lastidx.downto(@start_idx) do |i|
    #   @store[i] = @store[i-1]
    # end
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length +=1
    p @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    @store2 = StaticArray.new(@capacity * 2)
    0.upto(@capacity - 1) do |i|
      @store2[i] = @store[@start_idx]
      @start_idx = (@start_idx + 1) % capacity
    end
    @capacity *= 2
    @start_idx = 0
    @store = @store2
  end
end

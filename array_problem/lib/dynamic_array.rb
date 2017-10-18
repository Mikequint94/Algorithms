require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    if index >= @length
      raise "index out of bounds"
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
      @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    popped = @store[@length]
    @store[@length] = nil
    @length -=1
    return popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity
      @capacity *= 2
    end
    @length += 1
    @store[@length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    @length -=1
    shifted = @store[0]
    (0).upto(@length-1) do |i|
      @store[i] = @store[i+1]
    end
    @store[@length] = nil
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length.downto(0) do |i|
      @store[i] = @store[i-1]
    end
    @length +=1
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end

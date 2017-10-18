# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @maxcapacity = 8
    @maxlength = 0
    @maxstart_idx = 0
    @store = StaticArray.new(@capacity)
    @maxstore = StaticArray.new(@capacity)
  end

  def enqueue(val)
    if @length == @capacity
      @capacity *= 2
    end
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
    unless @maxstore[@maxstart_idx] && @maxstore[@maxstart_idx] > val
      if @maxlength == @maxcapacity
        @maxcapacity *= 2
      end
      @maxstore[@maxstart_idx] = val
      @maxlength += 1
    end
  end

  def dequeue
    @store[@start_idx % @capacity] = nil
    @start_idx = @start_idx + 1
    @length -= 1
  end

  def max
    @maxstore[0]
  end

  def length
    @length
  end

end

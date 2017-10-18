require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      if @count == num_buckets
        resize!
      end
      self[key.hash] << key
      @count += 1
    end
  end

  def include?(key)
    self[key.hash].include?(key)

  end

  def remove(key)
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @old_store = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    @old_store.each do |el|
      until el.empty?
        insert(el.shift)
        @count -=1
      end
    end
  end
end

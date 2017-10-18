class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, idx|
      if el.is_a?(Array)
        return el.hash
      else
        result += el*237/(idx+17)
      end
    end
    result
  end
end

class String
  def hash
    result = 0
    self.chars.each_with_index do |ch, idx|
      result += ch.ord * 231*(idx+17)/34
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    self.keys.each do |key|
      result += key.hash * self[key].hash
    end
    result
  end
end

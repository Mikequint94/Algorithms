def well_formed?(str)
  #stack
  opens = ["(", "{", "["]
  closes = [")", "}", "]"]
  opens_stack = []
  closes_stack = []

  str.each_char do |ch|
    if opens.include?(ch)
      opens_stack.push(ch)
    elsif closes.include?(ch)
      return false unless opens.index(opens_stack.pop) == closes.index(ch)
    end
  end
  return true
end

p well_formed?("()([{{{}}}])[[]]")

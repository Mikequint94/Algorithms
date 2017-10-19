require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  @map = HashMap.new()
  string.each_char do |ch|
    @map.set(ch.hash, ch)
  end
end

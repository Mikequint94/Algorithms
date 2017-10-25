class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {1 => [[1]], 2 => [[1,1],[2]], 3 => [[1,1,1],[1,2],[2,1],[3]]}
  end
  #
  # def blair_helper(n) #for bottom-up
  #   return @blair_cache if n<3
  #   (3..n).each do |i|
  #     @blair_cache[i] = @blair_cache[i-1] + @blair_cache[i-2] + (i-1)*2 - 1
  #   end
  #
  #   @blair_cache
  # end
  # [1, 1, 1], [1, 2], [2, 1], and [3].
  # [1,1,1,1], [1,1,2],[1,2,1],[2,1,1],[1,3],[3,1],[2,2],

  def blair_nums(n)
    #for bottom-up
    # blair_helper(n)
    # return @blair_cache[n]
    return @blair_cache[n] unless @blair_cache[n].nil?
    ans = blair_nums(n-1) + blair_nums(n-2) + (n-1)*2 - 1
    @blair_cache[n] = ans
    return ans
  end

  def frog_hops_bottom_up(n)
    frog_cache = frog_cache_builder(n)
    return frog_cache[n]
  end

  def frog_cache_builder(n)
    frog_cache = {1 => [[1]], 2 => [[1,1],[2]], 3 => [[1,1,1],[1,2],[2,1],[3]]}
    return frog_cache if n < 4
    (4..n).each do |i|
      frog_cache[i] = []
      step1 = frog_cache[i-1].each do |el|
        frog_cache[1].each do |base1|
          frog_cache[i] << el  + base1 unless frog_cache[i].include?(el + base1)
        end
      end
      step2 = frog_cache[i-2].each do |el|
        frog_cache[2].each do |base2|
          frog_cache[i] << el  + base2 unless frog_cache[i].include?(el + base2)
        end
      end
      step3 = frog_cache[i-3].each do |el|
        frog_cache[3].each do |base3|
          frog_cache[i] << el  + base3 unless frog_cache[i].include?(el + base3)
        end
      end
    end

    return frog_cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    frog_hops_top_down_helper(n)

  end

  def frog_hops_top_down_helper(n)
    @frog_cache[n] = []
    frog_hops_top_down(n-1).each do |el|
      @frog_cache[1].each do |base1|
        @frog_cache[n] << el + base1 unless @frog_cache[n].include?(el + base1)
      end
    end
    frog_hops_top_down(n-2).each do |el|
      @frog_cache[2].each do |base2|
        @frog_cache[n] << el + base2 unless @frog_cache[n].include?(el + base2)
      end
    end
    frog_hops_top_down(n-3).each do |el|
      @frog_cache[3].each do |base3|
        @frog_cache[n] << el + base3 unless @frog_cache[n].include?(el + base3)
      end
    end

    return @frog_cache[n]
  end

  def super_frog_hops(n, k)
    cache = { 1 => [[1]]}
    cache = create_n_bases_cache(n, cache)
      if k > n
        return cache[n]
      else
        ((k+1)..n).each do |num3|
          new_hops = []
          (1..k).each do |num4|
            cache[num3 - num4].each do |hops|
              cache[num4].each do |base_hops|
                new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
              end
            end
          end
          cache[num3] = new_hops
        end
      end
      cache[n]
  end

  def create_n_bases_cache(n, cache)
    (2..n).each do |num|
      new_hops = []
      (1..num - 1).each do |num2|
        cache[num2].each do |hops|
          cache[num - num2].each do |base_hops|
            new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
          end
        end
      end
      cache[num] = new_hops + [[num]]
    end
    return cache
  end

  def knapsack(weights, values, capacity)
    table = knapsack_table(weights, values, capacity)
    table[weights.length][capacity]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    num_items = weights.length
    #create the hash
    weight_val_hash = {}
    (1..num_items).each do |i|
      weight_val_hash[i] = [weights[i - 1], values[i - 1]]
    end
    table = Array.new(num_items + 1) { Array.new(capacity + 1)}
    table[0].each_index do |idx|
      table[0][idx] = 0
    end
    (1..num_items).each do |i|
      weight, value = weight_val_hash[i]
      (0..capacity).each do |j|
        if weight > j
          table[i][j] = table[i-1][j]
        else
          table[i][j] = [table[i-1][j], table[i-1][j - weight] + value].max
        end
      end
    end
    return table
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

module Fibonacci
  module Generate
    extend self

    def call(n)
      if !n.is_a?(Integer) || n < 1
        return [false, 'n must be a positive integer']
      end

      seq = [nil]
      idx = 1
      while idx <= n
        if idx == 1
          seq << 0
        elsif idx == 2
          seq << 1
        else
          seq << seq[idx-1] + seq[idx-2]
        end

        idx += 1
      end

      matrix = [seq]
      idx = 1
      while idx <= n
        col = seq[idx]
        row = [col]
        j = 1
        while j <= n
          row << col * seq[j]
          j += 1
        end

        matrix << row
        idx += 1
      end

      [true, matrix]
    end
  end
end

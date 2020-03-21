module Fibonacci
  module Print
    extend self

    def call(matrix)
      matrix[0][0] = ' '
      matrix.map do |row|
        row.join ' '
      end
    end
  end
end

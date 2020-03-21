module Backapp
  module Fetch
    extend self

    def call(n)
      cache = Backapp::Database.fetch n

      if cache
        [true, cache]
      else
        Fibonacci::Generate.call(n)
      end
    end
  end
end

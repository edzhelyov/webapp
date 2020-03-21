module Backapp
  module Save
    extend self

    def call(n)
      success, result = Fibonacci::Generate.call(n)

      if success
        Backapp::Database.cache n, result
        [true, result]
      else
        [false, result]
      end
    end
  end
end

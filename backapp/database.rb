require 'sqlite3'
require 'json'

module Backapp
  module Database
    extend self

    DB = SQLite3::Database.new ENV['DATABASE']

    DB.execute <<-SQL
  CREATE TABLE IF NOT EXISTS numbers (
    n int NOT NULL UNIQUE,
    matrix TEXT NOT NULL
  );
    SQL

    def fetch(n)
      row = DB.execute "SELECT matrix FROM numbers WHERE n = #{n}"
      if row.empty?
        nil
      else
        JSON.parse row[0][0]
      end
    end

    def cache(n, matrix)
      json = JSON.generate(matrix)
      sql = "INSERT INTO numbers(n, matrix) VALUES(#{n}, '#{json}') ON CONFLICT(n) DO UPDATE SET matrix='#{json}';"
      DB.execute sql
    end
  end
end

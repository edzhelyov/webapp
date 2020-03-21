require 'spec_helper'
require 'rack/test'

ENV['DATABASE'] = 'test.db'
require 'backapp/app'

describe 'Backapp::App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :each do
    Backapp::Database::DB.execute 'DELETE FROM numbers'
  end

  after :all do
    `rm -f test.db`
  end

  it 'generates the matrix if there is no cache' do
    get '/fibonacci?n=1'

    _, result = Fibonacci::Generate.call 1

    last_response.body.should eq result.to_json
  end

  it 'fetches the matrix from the cache' do
    Backapp::Database.cache 1, '[]'

    get '/fibonacci?n=1'

    last_response.body.should eq '"[]"'
  end

  it 'saves the matrix in the database' do
    post '/fibonacci', n: 2

    _, result = Fibonacci::Generate.call 2

    Backapp::Database.fetch(2).should eq result

    last_response.body.should eq result.to_json
  end
end

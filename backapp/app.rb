$LOAD_PATH << File.expand_path('../..', __FILE__)
ENV['DATABASE'] ||= 'fibonacci.db'

require 'sinatra'
require 'consoleapp/generate'
require_relative './database'
require_relative './fetch'
require_relative './save'

get '/fibonacci' do
  n = params['n'].to_i

  success, result = Backapp::Fetch.call n

  content_type :json
  if success
    result.to_json
  else
    {error: result}.to_json
  end 
end

post '/fibonacci' do
  n = params['n'].to_i

  success, result = Backapp::Save.call n

  content_type :json
  if success
    result.to_json
  else
    {error: result}.to_json
  end 
end

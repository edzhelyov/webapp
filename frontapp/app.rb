$LOAD_PATH << File.expand_path('../..', __FILE__)

require 'sinatra'
require 'json'
require 'httparty'

set :backapp_url, 'http://' + ENV['BACKAPP_URL'] + '/fibonacci'

get '/' do
  if params[:n]
    response = HTTParty.get settings.backapp_url, query: { n: params[:n] }
    response = JSON.parse(response.body) if response.body

    if response.is_a?(Hash) && response['error']
      error = response['error']
    else
      matrix = response
    end
  end

  erb :index, locals: { n: params[:n], matrix: matrix, error: error, saved: nil }
end

post '/' do
  response = HTTParty.post settings.backapp_url, body: { n: params[:n] }
  response = JSON.parse(response.body) if response.body

  if response.is_a?(Hash) && response['error']
    error = response['error']
  else
    matrix = response
  end

  erb :index, locals: { n: params[:n], matrix: matrix, error: error, saved: true}
end

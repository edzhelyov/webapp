require 'spec_helper'
require 'rack/test'
require 'capybara/dsl'

ENV['BACKAPP_URL'] = 'backapp'

require 'frontapp/app'

RSpec.configure do |config|
  config.include Capybara::DSL
end
Capybara.app = Sinatra::Application

describe 'Frontapp::App' do
  it 'submits a request to the backapp service' do
    response = instance_double HTTParty::Response, body: '[[null, 0], [0, 0]]'
    HTTParty.stub get: response

    visit '/'

    fill_in :n, with: 1
    click_on 'Generate'

    page.status_code.should eq 200
    page.should have_content('0')
    page.should have_button('Save')
  end

  it 'saves the generated matrix to the backapp service' do
    response = instance_double HTTParty::Response, body: '[[null, 0], [0, 0]]'
    HTTParty.stub get: response
    HTTParty.stub post: response

    visit '/?n=1'

    page.status_code.should eq 200
    page.should have_content('0')

    click_on 'Save'

    page.status_code.should eq 200
    page.should have_content('Saved!')
  end
end

require 'sinatra'
require 'sinatra/reloader' if development?
require './wsg-scrape'
require './wsg-info'

# set :port, 80

get '/wsg-info' do
    content_type :json
    json_data = get_wsg_info_scrape()
    json_data
end

get '/wsg' do 
    content_type :json
    get_wsg_info()
end

get '/' do 
    '<center><h1>Hey hey!</h1></center>'
end
require 'sinatra'
require './wsg-info'

# set :port, 80

get '/wsg-info' do
    content_type :json
    json_data = get_wsg_info()
    json_data
end

get '/' do 
    '<center><h1>Hello there!</h1></center>'
end
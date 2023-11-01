require 'sinatra'
require './wsg-info'

get '/wsg-info' do
    content_type :json
    json_data = get_wsg_info()
    json_data
end
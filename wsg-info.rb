require 'httparty'
require 'nokogiri'
require 'json'

def get_wsg_info
    url = "https://github.com/w3c/sustyweb/blob/main/guidelines.json"
    response = HTTParty.get(url)

    if response.code == 200
        puts "success!"
    else
        puts "failed :( #{response.code}"
    end
end
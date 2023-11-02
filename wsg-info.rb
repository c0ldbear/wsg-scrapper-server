require 'httparty'
require 'nokogiri'
require 'json'

def get_wsg_info
    url = "https://w3c.github.io/sustyweb"
    response = HTTParty.get(url)
    save_to_json = true
    wsg_info = []

    if response.code == 200
        puts "Success!"
        
        # Allocation of variables
        html_doc = Nokogiri::HTML(response.body) 
        
        # Parse titles
        titles = []
        html_doc.css('h3').each do | title |
            titles.append(title.text)
        end

        # Clean titles
        titles.shift(6) # 6 is the number of the first 6 topics, the Introduction
        titles.pop(4)   # 4 is the number of the last 4 topics, the Appendix

        # Parse ratings (Impact and Effort)
        ratings = []
        html_doc.css('dl.rating').each do | dl_tag |
            dl_tag.css('dd').each do | rating |
                ratings.append(rating.text)
            end
        end

        # Clean ratings
        ratings.shift(9) # 9 is the number of the first 9 explanations of the Impact and Effort part

        # Create the Hash that contains the Title and corresponding Rating (Impact and Effort)
        titles.each_with_index do | key, index |
            start_index = index * 2

            id_value, title_value = key.split(/ /, 2)
            impact_value = ratings[start_index]
            effort_value = ratings[start_index + 1]

            sub_hash = {Constant::ID => id_value, Constant::TITLE => title_value, Constant::IMPACT => impact_value, Constant::EFFORT => effort_value}
            wsg_info.append(sub_hash)
        end

    else 
        puts "Failed: #{response.code}"
    end

    # JSON.generate(wsg_info)
    wsg_info.to_json
end

class Constant
    ID = "Id"
    TITLE = "Title" 
    IMPACT = "Impact" 
    EFFORT = "Effort" 
    FILENAME = "wsg-titles-impacts-efforts"
end
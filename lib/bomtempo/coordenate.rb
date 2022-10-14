module Bomtempo
  require 'httparty'
  
  class Coordenate
    API_GEO='https://api.openweathermap.org/geo/1.0/direct'

    def initialize(args)
      @city = args[:city]
      @state = args[:state]
      @country = args[:country] || "BR"
    end       

    def get
      return "City is required" unless !@city.nil?
      return "State is required" unless !@state.nil?
  
      parameters = I18n.transliterate [@city, @state, @country].join(',') 
       
      url = "#{API_GEO}?q=#{parameters}&limit=5&appid=#{Class.nesting[-1].get_token}" 
      response = JSON.parse(HTTParty.get(url).body)[0]

      return if response.nil?

      {
        coordenate: {
          lat: response["lat"],
          lon: response["lon"],
        }, 
        city: response["name"]
      }
    end
  end
end
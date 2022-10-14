module Bomtempo
  require 'httparty'

  class OneCall
    API_ONE_CALL = "https://api.openweathermap.org/data/3.0/onecall"

    def initialize(locate)
      @lat = (locate[:coordenate] && locate[:coordenate][:lat])? locate[:coordenate][:lat] : nil
      @lon = (locate[:coordenate] && locate[:coordenate][:lon])? locate[:coordenate][:lon] : nil
      @city = locate[:city]
    end

    def next_five_days
      return "City is required" unless !@city.nil?
      return "Coordenate is required" unless !@lat.nil? || !@lon.nil?

      url = "#{API_ONE_CALL}?lat=#{@lat}&lon=#{@lon}" + 
            "&appid=#{Class.nesting[-1].get_token}" + 
            "&units=metric&lang=pt_BR&exclude=hourly,minutely,alerts"

      response = JSON.parse(HTTParty.get(url).body)
      generate_body(response["daily"])
    end

    private

    def generate_body(args)
      txt = ""
      txt += "#{args[0]["temp"]["day"].ceil}°C #{args[0]["weather"][0]["description"]} em #{@city} em #{Time.at(args[0]["dt"]).strftime('%d/%m')}."
      txt += " Média para os próximos dias:"

      args.each_with_index do |item, index|
        next if index == 0
        next if index > 5

        txt +=  " #{item["temp"]["day"].ceil}°C em "+
                "#{Time.at(item["dt"]).strftime('%d/%m')}"+
                "#{(index == 5)? ".": ","}"
      end

      txt
    end
  end
end
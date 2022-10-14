class Stub < Minitest::Test
  def before_setup
    Bomtempo.config do |c|
      c.access_token = "12345"
    end 

    stub_request(:any, "https://api.openweathermap.org/geo/1.0/direct?appid=12345&limit=5&q=Cuiaba,MT,BR")
      .to_return(
        status: 200,
        body: '[{ "name": "Cuiabá", "lat": "-15.5986686", "lon": "-56.0991301" }]'
      )

      response = OpenStruct.new
      response.daily = []
      5.times do |item| 
        response.daily << {
          "dt": 1665673200,
          "temp": {
            "day": 31.98,
          },
          "weather": [
            {
              "description": "nublado",
            }
          ]
        }
      end
  
      stub_request(:any, "https://api.openweathermap.org/data/3.0/onecall?lat=-15.5986686&lon=-56.0991301&appid=12345&units=metric&lang=pt_BR&exclude=hourly,minutely,alerts")
      .to_return(
        status: 200,
        body: response.to_h.to_json
      )
  end
end
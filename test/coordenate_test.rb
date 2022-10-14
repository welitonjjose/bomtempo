require 'minitest/autorun'
require 'webmock/minitest'
require './lib/bomtempo'
require './lib/bomtempo/coordenate'
require_relative 'stub'


class CoordenateTest < Stub
  CITY = "Cuiabá"
  LAT  = "-15.5986686"
  LON  = "-56.0991301"

  
  def test_the_truth
    locate = Bomtempo::Coordenate.new({
      city: "Cuiaba",
      state: "MT",
      country: "BR"
    }).get
    
   
    assert_equal locate[:city],               "Cuiabá",      "the truth: City -> OK"
    assert_equal locate[:coordenate][:lat],   "-15.5986686", "the truth: Lat -> OK"
    assert_equal locate[:coordenate][:lon],   "-56.0991301", "the truth: Lon -> OK"
  end

  def test_the_city_empty
    locate = Bomtempo::Coordenate.new({
      state: "MT",
      country: "BR"
    }).get
   
    assert_equal locate, "City is required"
  end

  def test_the_state_empty
    locate = Bomtempo::Coordenate.new({
      city: "Cuiaba",
      country: "BR"
    }).get
   
    assert_equal locate, "State is required"
  end

  def test_coordenate_not_found
    stub_request(:any, "https://api.openweathermap.org/geo/1.0/direct?appid=12345&limit=5&q=sinop,SP,BR")
    .to_return(
      status: 200,
      body: '[]'
    )

    locate = Bomtempo::Coordenate.new({
      city: "sinop",
      state: "SP",
    }).get
    
    assert_nil locate 
  end
end
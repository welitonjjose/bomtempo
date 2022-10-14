require 'minitest/autorun'
require 'webmock/minitest'
require './lib/bomtempo'
require './lib/bomtempo/one_call'
require_relative 'stub'

class OneCallTest < Stub

  def test_the_truth
    onecall = Bomtempo::OneCall.new({
      coordenate: {
        lat: -15.5986686,
        lon: -56.0991301
      },
      city: "Patos de Minas"
    }).next_five_days
   
      assert_equal onecall, "32°C nublado em Patos de Minas em 13/10. Média para os próximos dias: 32°C em 13/10, 32°C em 13/10, 32°C em 13/10, 32°C em 13/10,"
  end

  def test_the_not_city
    onecall =  Bomtempo::OneCall.new({
      coordenate: {
        lat: -15.5986686,
        lon: -56.0991301
      },
    }).next_five_days

    assert "City is required"
  end

  def test_the_not_coordenate
    onecall =  Bomtempo::OneCall.new({
      city: "Patos de Minas"
    }).next_five_days

    assert "Coordenate is required"
  end
end
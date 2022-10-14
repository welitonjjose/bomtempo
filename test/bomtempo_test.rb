require 'minitest/autorun'
require_relative 'stub'
require './lib/bomtempo'
require 'webmock/minitest'

require_relative 'coordenate_test'
require_relative 'one_call_test'

class BomtempoTest < Stub

  def test_the_truth
    Bomtempo.weather_in({
      city: "Cuiaba",
      state: "MT",
    })

    assert true
  end

  # def test_the_fail
  #   assert true
  # end
end
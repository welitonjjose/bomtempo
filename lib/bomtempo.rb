# frozen_string_literal: true

require_relative "bomtempo/version"

require_relative "bomtempo/coordenate"
require_relative "bomtempo/one_call"

module Bomtempo
  class Error < StandardError; end

  class << self
    attr_accessor :access_token

    def config 
      yield self
    end

    def weather_in(args)
      locate = Coordenate.new(args).get
      OneCall.new(locate).next_five_days
    end

    def get_token
      @access_token
    end
  end
end


# https://api.openweathermap.org/data/2.5/weather?lat=-15.5986686&lon=-56.0991301&appid=27a54f60a77ebe0a3d6bb5f926753e03
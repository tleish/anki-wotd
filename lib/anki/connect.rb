require 'anki/connect/version'
require 'anki/connect/configuration'
require 'anki/connect/client'
require 'anki/connect/deck'
require 'anki/connect/card_creator'
require 'anki/connect/card_query'

module Anki
  module Connect
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end

require 'anki/wotd/version'
require 'anki/wotd/configuration'
require 'anki/wotd/ankify'
require 'anki/wotd/card'
require 'anki/wotd/words'
require 'anki/wotd/dictionary_parts'
require 'anki/wotd/dictionary_decorator'
require 'anki/wotd/rss'


module Anki
  module Wotd
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

require 'simple-rss'
require 'open-uri'
require 'forwardable'
require 'xmlsimple'


module Anki
  module Wotd
    class Rss
      extend SingleForwardable
      def_delegators :new, :get, :words, :descriptions, :url

      attr_reader :configuration
      def initialize(configuration = Anki::Wotd.configuration)
        @configuration = configuration
      end

      def get
        @rss ||= SimpleRSS.parse open(configuration.rss_url)
        XmlSimple.xml_in(@rss.source)
      end

      def url
        configuration.rss_url
      end

      def words
        get['channel'].first['item']
      end

      def descriptions
        words.map { |word| word['description'].first }
      end
    end
  end
end


module Anki
  module Wotd
    class Configuration
      RSS_URL = 'http://feeds.feedburner.com/wordthink/vIYJ?format=xml'.freeze

      attr_accessor :rss_url
      def initialize
        @rss_url = RSS_URL
      end
    end
  end
end

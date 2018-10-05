require 'anki/connect/client'

module Anki
  module Connect
    using JsonStringRefinement

    class CardQuery
      ACTION = 'findCards'.freeze
      attr_reader :query, :configuration

      def initialize(query:, configuration: Anki::Connect.configuration)
        @query = "deck:#{configuration.deck_name} " + query
        @configuration = configuration
      end

      def self.search(query)
        new(query: query).body
      end

      def body
        @body ||= response.body.parse_json
      end

      def response
        @response ||= Client.post(action: ACTION, params: { query: query })
      end
    end
  end
end

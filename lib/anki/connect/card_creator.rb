require 'anki/connect/client'

module Anki
  module Connect
    using JsonStringRefinement

    class CardCreator
      ACTION = 'addNote'.freeze
      attr_reader :card, :configuration

      def initialize(card:, configuration: Anki::Connect.configuration)
        @card = card
        @configuration = configuration
      end

      def self.add(card:, configuration: Anki::Connect.configuration)
        new(card: card, configuration: configuration).add
      end

      def add
        @add ||= response.body.parse_json
      end

      def response
        @response ||= Client.post(action: ACTION, params: { note: card })
      end
    end
  end
end

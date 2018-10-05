require 'anki/connect/client'

module Anki
  module Connect
    module Deck
      using JsonStringRefinement

      class Creator
        ACTION = 'createDeck'.freeze
        attr_reader :params, :configuration

        def initialize(deck:, configuration: Anki::Connect.configuration)
          @params = { deck: deck }
          @configuration = configuration
        end

        def self.run(deck:, configuration: Anki::Connect.configuration)
          new(*args).run
        end

        def run
          @run ||= response.body.parse_json
        end

        def response
          @response ||= Client.post(action: ACTION, params: params)
        end
      end
    end
  end
end

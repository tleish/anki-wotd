require 'anki/connect/client'

module Anki
  module Connect
    module Deck
      using JsonStringRefinement

      class Info
        ACTION = 'deckNamesAndIds'.freeze
        attr_reader :configuration

        def initialize(configuration: Anki::Connect.configuration)
          @configuration = configuration
        end

        def id
          body[name]
        end

        def name
          configuration.deck_name
        end

        def body
          @body ||= response.body.parse_json
        end

        def response
          @response ||= Client.post(action: ACTION)
        end
      end
    end
  end
end

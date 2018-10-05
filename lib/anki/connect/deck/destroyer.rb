require 'anki/connect/client'

module Anki
  module Connect
    module Deck
      using JsonStringRefinement

      class Destroyer
        ACTION = 'deleteDecks'.freeze
        attr_reader :params, :configuration

        def initialize(params:, configuration: Anki::Connect.configuration)
          @params = params
          @configuration = configuration
        end

        def self.run(params:, configuration: Anki::Connect.configuration)
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

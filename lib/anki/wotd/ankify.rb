require 'anki/connect'
require 'anki/wotd'

module Anki
  module Wotd
    class Ankify
      attr_reader :definitions, :configuration
      def initialize(definitions: , configuration: Anki::Connect.configuration)
        @configuration = configuration
        @definitions = Array(definitions)
      end

      def add
        cards.each do |card|
          if card.ankified?
            puts "#{card.word} (skipped)"
          else
            Anki::Connect::CardCreator.add(card: card.to_json, configuration: configuration)
            "#{card.word} (created)"
          end
        end
      end

      def cards
        definitions.map do |definition|
          Card.new(definition: definition)
        end
      end
    end
  end
end

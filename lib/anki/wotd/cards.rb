require 'anki/connect'

module Anki
  module Wotd
    class Cards
      include Enumerable
      attr_reader :definitions
      def initialize(definitions:)
        @definitions = Array(definitions)
      end

      def each(&block)
        definitions.each do |definition|
          block.call(Card.new(definition: definition))
        end
      end
    end

    class Card
      attr_reader :definition, :configuration
      def initialize(definition:, configuration: Anki::Connect.configuration)
        @definition = definition
        @configuration = configuration
      end

      def word
        definition.word
      end

      def to_json
        base_json.merge(definition.to_json)
      end

      def base_json
        {
            deckName: configuration.deck_name,
            modelName: configuration.model_name,
            tags: ['wotd']
        }
      end

      def ankified?
        !Anki::Connect::CardQuery.search("tag:wotd Text:*{{c1::#{definition.word}}}*").empty?
      end

      def to_text
        puts "#" * 10
        print definition.card
        puts "\n" * 2
        print definition.note
        puts
        puts "#" * 10
      end
    end
  end
end
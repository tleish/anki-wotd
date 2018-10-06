require 'anki/connect'
require 'anki/wotd/cards'

module Anki
  module Wotd
    class Ankify
      attr_reader :cards, :configuration
      def initialize(cards: , configuration: Anki::Connect.configuration)
        @configuration = configuration
        @cards = Array(cards)
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
    end
  end
end

require 'anki/connect'
require 'anki/wotd/cards'

module Anki
  module Wotd
    class Ankify
      attr_reader :cards, :configuration
      def initialize(cards:, configuration: Anki::Connect.configuration)
        @cards = Array(cards)
        @configuration = configuration
      end

      def create
        creators.each(&:create)
      end

      def creators
        cards.map do |card|
          CardCreatorFactory.for(card)
        end
      end
    end

    class CardCreatorFactory
      SEARCH_TEMPLATE = 'tag:wotd Text:*{{c1::%s}}*'.freeze
      def self.for(card)
        if card.ankified?
          NullCardCreator.new(card: card)
        else
          CardCreator.new(card: card)
        end
      end
    end

    class BaseCardCreator
      STATUS = 'NA'.freeze
      attr_reader :card, :configuration
      def initialize(card:, configuration: Anki::Connect.configuration)
        @card = card
        @configuration = configuration
      end

      def create
        puts "#{card.word} (#{self.class::STATUS})"
      end
    end

    class CardCreator < BaseCardCreator
      STATUS = 'created'.freeze
      def create
        Anki::Connect::CardCreator.add(card: card.to_json, configuration: configuration)
        super
      end
    end

    class NullCardCreator < CardCreator
      STATUS = 'skipped'.freeze
    end
  end
end

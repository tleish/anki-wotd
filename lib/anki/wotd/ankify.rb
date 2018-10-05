require 'anki/connect'
require 'anki/wotd'
require 'anki/oxford_dictionary'

module Anki
  module Wotd
    class Ankify
      attr_reader :configuration
      def initialize(words: [], configuration: Anki::Connect.configuration)
        @configuration = configuration
        @words = words unless Array(words).empty?
      end

      def add
        cards.each do |card|
          Anki::Connect::CardCreator.add(card: card, configuration: configuration)
        end
      end

      def cards(skip_ankified = true)
        words.map do |word|
          if skip_ankified && ankified?(word)
            puts "#{word.downcase} (skipped)"
            next
          else
            begin
              entry = entry(word)
              puts "#{entry.word} (created)"
              base_json.merge(entry.to_json)
            rescue ::OxfordDictionary::Error => error
              puts "#{word} (error: #{error.message})"
            end
          end
        end.compact
      end

      def base_json
        @base_json ||= {
            deckName: configuration.deck_name,
            modelName: configuration.model_name,
            tags: ['wotd']
        }
      end

      def ankified?(word)
        !Anki::Connect::CardQuery.search("tag:wotd Text:*{{c1::#{word}}}*").empty?
      end

      def entry(word)
        entry = configuration.oxford_dictionary_client.entry(word)
        Anki::OxfordDictionary::DictionaryDecorator.new(entry)
      end

      def words
        @words ||= begin
          puts "Getting definitions #{Rss.url}..."
          Rss.descriptions.map do |description|
            parts = DictionaryParts.new(description)
            DictionaryDecorator.new(parts).word
          end
        end
      end
    end
  end
end

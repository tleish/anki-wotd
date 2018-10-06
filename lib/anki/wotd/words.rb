require 'anki/connect'
require 'anki/wotd'
require 'anki/oxford_dictionary'

module Anki
  module Wotd
    class Words
      attr_reader :words, :configuration
      def initialize(words: [], configuration: Anki::Connect.configuration)
        @configuration = configuration
        @words = words unless Array(words).empty?
      end

      def definitions
        @definitions ||= words.map { |word| entry(word) }.compact
      end

      def entry(word)
        entry = configuration.oxford_dictionary_client.entry(word)
        Anki::OxfordDictionary::DictionaryDecorator.new(entry)
      rescue ::OxfordDictionary::Error => error
        puts "#{word} (error: #{error.message})"
      end

      def words
        @words ||= begin
          Rss.descriptions.map do |description|
            parts = DictionaryParts.new(description)
            DictionaryDecorator.new(parts).word
          end
        end
      end
    end
  end
end

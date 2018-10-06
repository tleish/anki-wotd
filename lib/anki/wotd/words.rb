require 'anki/connect'
require 'anki/wotd/dictionary_parts'
require 'anki/wotd/dictionary_decorator'
require 'anki/oxford_dictionary'

module Anki
  module Wotd
    class Words
      include Enumerable
      attr_reader :configuration
      def initialize(words: [], configuration: Anki::Connect.configuration)
        @configuration = configuration
        @words = words unless Array(words).empty?
      end

      def each(&block)
        definitions.each do |definition|
          block.call(definition)
        end
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

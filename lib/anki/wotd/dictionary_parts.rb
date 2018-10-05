require 'htmlentities'
require 'singleton'

module Anki
  module Wotd
    # parse parts of a dictionary
    class DictionaryParts
      extend Forwardable
      attr_reader :text
      def initialize(text)
        @text = text
        @parts = find
      end
      def_delegators :@parts, :word, :pronunciation, :part_of_speech, :definitions

      def find
        unescaped_description = HTMLEntities.new.decode(text).gsub(/&#822[01];/, '"')
        match = WordDefinitionRegexp.match(unescaped_description)
        OpenStruct.new(match.named_captures)
      end
    end

    class WordDefinitionRegexp < Regexp
      include Singleton
      NAMED_GROUPS = {
          word: '<[a-z]+>(?<%s>[a-zA-Z]+)[^<]*</[a-z]+>',
          pronunciation: '(?<%s>\[[^\]]+\])',
          part_of_speech: '<[a-z]+>(?<%s>[^<]+)</[a-z]+>',
          definitions: '(?<%s>.*)'
      }.freeze

      def initialize
        super(%r{<p>[^<]*#{named_groups}</p>})
      end

      def named_groups
        NAMED_GROUPS.map { |name, regex| regex % name }.join(' ')
      end

      def self.match(definition)
        definition.match(instance)
      end
    end
  end
end

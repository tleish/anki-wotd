require 'htmlentities'

module Anki
  module Wotd
    module EnumerateDefinitions
      refine Array do
        def enumerate
          each_with_index.map { |item, i| "#{i+1}. #{item}" }
        end
      end
    end
  end
end

using Anki::Wotd::EnumerateDefinitions

module Anki
  module Wotd
    # Decorator for Dictionary Entry
    class DictionaryDecorator < SimpleDelegator
      def card
        html = "<div>{{c1::<b>#{word}</b> #{pronunciation}}} #{part_of_speech}</div>"
        html << cloze_definitions_html
      end

      def cloze_definitions_html
        cloze_definitions.map { |definition| "<div>#{definition}</div>" }.join
      end

      def cloze_definitions
        close = definitions.gsub(%r{(<i>[a-zA-Z]+</i>)}i, "{{c1::\\1}}")
        definitions_array = close.split(/[0-9]+\. */)[1..-1]
                                 .map(&:strip)
                                 .enumerate
        if definitions_array.empty?
          [close]
        else
          definitions_array
        end
      end

      def definitions_without_examples
        split_definitions_from_examples.map(&:first).enumerate
      end

      def examples
        split_definitions_from_examples.map(&:last).enumerate
      end

      def split_definitions_from_examples
        definitions.split(/[0-9]+\. /)[1..-1]
          .map { |item| item.split(/: /).map(&:strip) }
      end
    end
  end
end

require 'oxford_dictionary'
require 'htmlbeautifier'

module Anki
  module OxfordDictionary
    module ClozeString
      refine String do
        def cloze(number)
          "{{c#{number}::#{self}}}"
        end
      end
    end
  end
end

using Anki::OxfordDictionary::ClozeString

module Anki
  module OxfordDictionary
    # Decorator for Dictionary Entry
    class DictionaryDecorator < SimpleDelegator
      def card
        HtmlBeautifier.beautify("#{word_html}#{lexical_entries_html.join}")
      end

      def note
        "Origin: #{lexical_entries_html.map(&:etymologies).join}"
      end

      def word_html
        "<h4>#{word.cloze(1)}</h4>"
      end

      def lexical_entries_html
        lexical_entries.map { |lexical_entry| LexicalEntryHtml.new(lexical_entry) }
      end

      def to_json
        {
          fields: {
            Text: card,
            Note: note,
          }
        }
      end
    end

    class LexicalEntryHtml < SimpleDelegator
      def to_s
        text = '<p>'
        text << lexical_category_html
        text << pronunciations_html
        text << entries_html
        text << '</p>'
      end

      def etymologies
        entries.map(&:etymologies)
      end

      def lexical_category_html
        "<i>#{lexical_category}</i>"
      end

      def pronunciations_html
        text = pronunciations.map do |pronunciation|
          %(<a href="#{pronunciation.audio_file}">/#{pronunciation.phonetic_spelling}</a>/)
        end
        " #{text.join(', ').cloze(1)}"
      end

      def entries_html
        entries.map { |entry| Entry.new(entry.senses).to_s }.join
      end
    end

    class Entry < SimpleDelegator
      def to_s
        return '' if empty?
        "<ol>#{senses_html}</ol>"
      end

      def senses_html
        map { |sense| Sense.new(sense).to_s }.join
      end
    end

    class Sense < SimpleDelegator
      def to_s
        text = '<li>'
        text << definitions.join('; ').cloze(2)
        text << examples_html
        text << Entry.new(subsenses).to_s
        text << '</li>'
      end

      def examples_html
        return '' if examples.flatten.empty?
        text = ': '
        text << %(<i>‘#{examples.flatten.map(&:text).join("', '")}'</i>).cloze(1)
      end
    end
  end
end

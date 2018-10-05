require 'test_helper'
require 'anki/wotd/dictionary_parts'

describe Anki::Wotd::DictionaryParts do
  subject { Anki::Wotd::DictionaryParts.new("&lt;p&gt;\r\n&lt;b&gt;Tenacious&lt;/b&gt; [te·na·cious] &lt;i&gt;adj.&lt;/i&gt; 1. Not readily letting go of, giving up, or separated from an object that one holds, a position, or a principle: &amp;#8220;A &lt;i&gt;tenacious&lt;/i&gt; hold.&amp;#8221; 2. Not easily dispelled or discouraged; persisting in existence or in a course of action: &amp;#8220;A &lt;i&gt;tenacious&lt;/i&gt; legend.&amp;#8221;&lt;/p&gt;&lt;img src=\"http://feeds.feedburner.com/~r/wordthink/vIYJ/~4/pekgiqDXthc\" height=\"1\" width=\"1\" alt=\"\"/&gt;") }

  it 'returns parts of the description' do
    subject.word.must_equal 'Tenacious'
    subject.pronunciation.must_equal '[te·na·cious]'
    subject.part_of_speech.must_equal 'adj.'
    subject.definitions.must_equal "1. Not readily letting go of, giving up, or separated from an object that one holds, a position, or a principle: \"A <i>tenacious</i> hold.\" 2. Not easily dispelled or discouraged; persisting in existence or in a course of action: \"A <i>tenacious</i> legend.\""
  end

  let (:vacillate) { Anki::Wotd::DictionaryParts.new(%(&lt;p&gt;\r\n&lt;b&gt;Vacillate&lt;/b&gt; [vac·il·late] &lt;i&gt;v.&lt;/i&gt; Alternate or waver between different opinions or actions; be indecisive. &amp;#8220;Her tendency to &lt;i&gt;vacillate&lt;/i&gt; made her a poor director.&amp;#8221;&lt;/p&gt;&lt;img src="http://feeds.feedburner.com/~r/wordthink/vIYJ/~4/oW7HXRKQjl4" height="1" width="1" alt=""/&gt;)) }

  it 'returns parts of vacillate' do
    vacillate.word.must_equal 'Vacillate'
    vacillate.pronunciation.must_equal '[vac·il·late]'
    vacillate.part_of_speech.must_equal 'v.'
    vacillate.definitions.must_equal "Alternate or waver between different opinions or actions; be indecisive. \"Her tendency to <i>vacillate</i> made her a poor director.\""
  end

  let (:indolent) { Anki::Wotd::DictionaryParts.new(%(&lt;p&gt;\r\n&lt;b&gt;indolent; Indolence&lt;/b&gt; [in·do·lent] &lt;i&gt;n.&lt;/i&gt; Alternate or waver between different opinions or actions; be indecisive. &amp;#8220;Her tendency to &lt;i&gt;vacillate&lt;/i&gt; made her a poor director.&amp;#8221;&lt;/p&gt;&lt;img src="http://feeds.feedburner.com/~r/wordthink/vIYJ/~4/oW7HXRKQjl4" height="1" width="1" alt=""/&gt;)) }

  it 'handles 2 words' do
    indolent.word.must_equal 'indolent'
  end
end

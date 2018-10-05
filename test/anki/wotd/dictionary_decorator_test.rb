require 'test_helper'
require 'anki/wotd/dictionary_decorator'

describe Anki::Wotd::DictionaryDecorator do
  let(:parts) {
    OpenStruct.new(
      word: 'Tenacious',
      pronunciation: '[te·na·cious]',
      part_of_speech: 'adj.',
      definitions: "1. Not readily letting go of, giving up, or separated from an object that one holds, a position, or a principle: \"A <i>tenacious</i> hold.\" 2. Not easily dispelled or discouraged; persisting in existence or in a course of action: \"A <i>tenacious</i> legend.\"",
    )
  }
  subject { Anki::Wotd::DictionaryDecorator.new(parts) }

  it 'returns parts of the description' do
    subject.word.must_equal 'Tenacious'
    subject.pronunciation.must_equal '[te·na·cious]'
    subject.part_of_speech.must_equal 'adj.'
    subject.definitions.must_equal "1. Not readily letting go of, giving up, or separated from an object that one holds, a position, or a principle: \"A <i>tenacious</i> hold.\" 2. Not easily dispelled or discouraged; persisting in existence or in a course of action: \"A <i>tenacious</i> legend.\""
  end

  it 'returns a cloze' do
    subject.cloze_definitions[0].must_equal "1. Not readily letting go of, giving up, or separated from an object that one holds, a position, or a principle: \"A {{c1::<i>tenacious</i>}} hold.\""
    subject.cloze_definitions[1].must_equal "2. Not easily dispelled or discouraged; persisting in existence or in a course of action: \"A {{c1::<i>tenacious</i>}} legend.\""
  end

  it 'returns a simplified definition without examples' do
    subject.definitions_without_examples[0].must_equal "1. Not readily letting go of, giving up, or separated from an object that one holds, a position, or a principle"
    subject.definitions_without_examples[1].must_equal "2. Not easily dispelled or discouraged; persisting in existence or in a course of action"
  end

  it 'returns examples' do
    subject.examples[0].must_equal "1. \"A <i>tenacious</i> hold.\""
    subject.examples[1].must_equal "2. \"A <i>tenacious</i> legend.\""
  end

  it 'returns a card' do
    puts subject.card.inspect
    subject.card.must_equal %(<div>{{c1::<b>Tenacious</b> [te·na·cious]}} adj.</div><div>1. Not readily letting go of, giving up, or separated from an object that one holds, a position, or a principle: "A {{c1::<i>tenacious</i>}} hold."</div><div>2. Not easily dispelled or discouraged; persisting in existence or in a course of action: "A {{c1::<i>tenacious</i>}} legend."</div>)
  end
  
  let(:vacillate_parts) {
    OpenStruct.new(
      word: 'Vacillate',
      pronunciation: '[vac·il·late]',
      part_of_speech: 'v.',
      definitions: %{Alternate or waver between different opinions or actions; be indecisive. \"Her tendency to <i>vacillate</i> made her a poor director.\"},
    )
  }
  let(:vacillate) { Anki::Wotd::DictionaryDecorator.new(vacillate_parts) }

  it 'handles only 1 definition' do
    vacillate.card.must_equal "<div>{{c1::<b>Vacillate</b> [vac·il·late]}} v.</div><div>Alternate or waver between different opinions or actions; be indecisive. \"Her tendency to {{c1::<i>vacillate</i>}} made her a poor director.\"</div>"
  end


  let(:transitory_parts) {
    OpenStruct.new(
        word: 'Transitory',
        pronunciation: '[tran·si·to·ry]',
        part_of_speech: 'adj.',
        definitions: %{1. Not lasting, enduring, permanent, or eternal. 2.Lasting only a short time; brief; short-lived; temporary. “It was a <i>transitory</i> stage in the actor’s career.”},
        )
  }
  let(:transitory) { Anki::Wotd::DictionaryDecorator.new(transitory_parts) }

  it 'handles only 2 definitions with Transitory' do
    transitory.card.must_equal "<div>{{c1::<b>Transitory</b> [tran·si·to·ry]}} adj.</div><div>1. Not lasting, enduring, permanent, or eternal.</div><div>2. Lasting only a short time; brief; short-lived; temporary. “It was a {{c1::<i>transitory</i>}} stage in the actor’s career.”</div>"
  end


end


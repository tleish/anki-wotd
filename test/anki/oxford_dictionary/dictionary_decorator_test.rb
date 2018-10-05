require 'test_helper'
require 'anki/oxford_dictionary/dictionary_decorator'

describe Anki::OxfordDictionary::DictionaryDecorator do
  let(:client) { OxfordDictionary.new(app_id: '123', app_key: '456') }
  let(:html) {
%(<h4>{{c1::insult}}</h4>
<p><i>Verb</i> {{c1::<a href="http://audio.oxforddictionaries.com/en/mp3/insult_gb_1.mp3">/ɪnˈsʌlt</a>/}}
  <ol>
    <li>{{c2::speak to or treat with disrespect or scornful abuse}}: {{c1::<i>‘you're insulting the woman I love'</i>}}</li>
  </ol>
</p>
<p><i>Noun</i> {{c1::<a href="http://audio.oxforddictionaries.com/en/mp3/insult_gb_2.mp3">/ˈɪnsʌlt</a>/}}
  <ol>
    <li>{{c2::a disrespectful or scornfully abusive remark or act}}: {{c1::<i>‘he saw the book as a deliberate insult to the Church', 'he hurled insults at us'</i>}}
      <ol>
        <li>{{c2::a thing so worthless or contemptible as to be offensive}}: {{c1::<i>‘the present offer is an absolute insult'</i>}}</li>
      </ol>
    </li>
    <li>{{c2::an event which causes damage to a tissue or organ}}: {{c1::<i>‘the movement of the bone causes a severe tissue insult'</i>}}</li>
  </ol>
</p>)
}

  let(:card) { "Origin: mid 16th century (as a verb in the sense ‘exult, act arrogantly’): from Latin insultare ‘jump or trample on’, from in- ‘on’ + saltare, from salire ‘to leap’. The noun (in the early 17th century denoting an attack) is from French insulte or ecclesiastical Latin insultus. The main current senses date from the 17th century, the medical use dating from the early 20th century" }
  it 'has a card' do
    entry = nil
    VCR.use_cassette('oxford_dictionary_insult') do
      entry = client.entry('insult')
    end

    entry_decorator = Anki::OxfordDictionary::DictionaryDecorator.new(entry)
    entry_decorator.card.must_equal html
  end

  it 'has a note' do
    entry = nil
    VCR.use_cassette('oxford_dictionary_insult') do
      entry = client.entry('insult')
    end

    entry_decorator = Anki::OxfordDictionary::DictionaryDecorator.new(entry)
    entry_decorator.note.must_equal card
  end

end


require 'test_helper'
require 'anki/connect'
require 'anki/connect/card_creator'

describe Anki::Connect::CardCreator do
  subject { Anki::Connect::CardCreator }

  it 'returns an id' do
    card = {
        deckName: 'Default',
        modelName: 'Basic',
        fields: {
          Front: 'front content',
          Back: 'back content'
        },
        tags: ['mytag']
      }
    VCR.use_cassette(subject::ACTION) do
      subject.add(card: card).must_equal 1535904022786
    end
  end

  it 'does not add a duplicate' do
    card = {
        deckName: 'Default',
        modelName: 'Basic',
        fields: {
            Front: 'front content',
            Back: 'back content'
        },
        tags: ['mytag']
    }
    VCR.use_cassette(subject::ACTION + 'Duplicate') do
      subject.add(card: card).must_be_nil
    end
  end
end

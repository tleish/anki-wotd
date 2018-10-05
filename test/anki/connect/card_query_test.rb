require 'test_helper'
require 'anki/connect'
require 'anki/connect/card_query'

describe Anki::Connect::CardQuery do
  subject { Anki::Connect::CardQuery }

  it 'returns an id' do
    VCR.use_cassette(subject::ACTION) do
      subject.search('Back:Fastidious*').must_equal [1535683581801]
    end
  end

  it 'returns an id' do
    VCR.use_cassette(subject::ACTION + 'bogus') do
      subject.search('Back:Bogus*').must_equal []
    end
  end
end

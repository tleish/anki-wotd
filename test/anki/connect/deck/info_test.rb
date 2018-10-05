require 'test_helper'
require 'anki/connect'
require 'anki/connect/deck/info'
require 'ostruct'

describe Anki::Connect::Deck::Info do
  subject { Anki::Connect::Deck::Info }
  it 'returns a name' do
    subject.new.name.must_equal 'Test'
  end

  it 'returns an id' do
    VCR.use_cassette(subject::ACTION) do
      subject.new.id.must_equal 1
    end
  end
end

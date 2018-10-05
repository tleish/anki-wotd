require 'test_helper'
require 'anki/wotd/ankify'

describe Anki::Wotd::Ankify do
  subject { Anki::Wotd::Ankify }
  it 'creates an array of cards' do
    ankify = subject.new
    front = "n.\n<div>1. Somebody who expresses an opinion: somebody who acts as a critic or authority on a particular subject, especially in the media. “The election results threw the political __________ into confusion.”</div>\n<div>2. Somebody wise: somebody with knowledge and wisdom.</div>"
    VCR.use_cassette('wordthink') do
        ankify.cards.must_equal 10
    end
  end
end

require 'test_helper'
require 'anki/wotd/rss'

describe Anki::Wotd::Rss do
  subject { Anki::Wotd::Rss.new(OpenStruct.new(rss_url: 'http://feeds.feedburner.com/wordthink/vIYJ')) }

  it 'returns an array from rss' do
    words = nil
    VCR.use_cassette('wordthink') do
      words = subject.words
    end
    words.first['title'].first.must_equal 'Pundit'
    words.first['description'].first.must_equal "<p>\n<b>Pundit</b> [pun·dit] <i>n.</i> 1. Somebody who expresses an opinion: somebody who acts as a critic or authority on a particular subject, especially in the media. &#8220;The election results threw the political <i>pundits</i> into confusion.&#8221; 2. Somebody wise: somebody with knowledge and wisdom.</p><img src=\"http://feeds.feedburner.com/~r/wordthink/vIYJ/~4/83U2t7BSkjs\" height=\"1\" width=\"1\" alt=\"\"/>"
  end

  it 'returns an array of descriptions' do
    descriptions = nil
    VCR.use_cassette('wordthink') do
      descriptions = subject.descriptions
    end
    descriptions.first.must_equal "<p>\n<b>Pundit</b> [pun·dit] <i>n.</i> 1. Somebody who expresses an opinion: somebody who acts as a critic or authority on a particular subject, especially in the media. &#8220;The election results threw the political <i>pundits</i> into confusion.&#8221; 2. Somebody wise: somebody with knowledge and wisdom.</p><img src=\"http://feeds.feedburner.com/~r/wordthink/vIYJ/~4/83U2t7BSkjs\" height=\"1\" width=\"1\" alt=\"\"/>"
  end
end

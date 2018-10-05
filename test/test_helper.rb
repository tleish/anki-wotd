$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'anki/wotd'
require 'anki/connect'

require 'minitest/spec'
require 'minitest/autorun'
require 'vcr'

Anki::Connect.configure do |config|
  config.deck_name = 'Test'
end

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :webmock
end

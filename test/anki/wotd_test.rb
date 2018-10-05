require 'test_helper'

describe Anki::Wotd do
  subject { Anki::Wotd }
  it "can has a version number" do
    subject::VERSION.wont_be_nil
  end
end

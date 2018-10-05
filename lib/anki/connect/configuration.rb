
module Anki
  module Connect
    # Configurations the anki connect client
    class Configuration
      URL = 'http://127.0.0.1:8765/'.freeze
      DECK_NAME = 'Default'.freeze
      MODEL_NAME = 'Basic Flip'.freeze

      attr_accessor :url, :deck_name, :model_name, :oxford_dictionary_client
      def initialize
        @url = URL
        @deck_name = DECK_NAME
        @model_name = MODEL_NAME
        @oxford_dictionary_client = nil
      end
    end
  end
end

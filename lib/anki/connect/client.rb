require 'rest_client'
require 'json'
require 'colorize'

module Anki
  module Connect
    class Client
      HEADERS = { content_type: :json, accept: :json }
      def self.post(action:, params: {}, configuration: Anki::Connect.configuration)
        url = configuration.url
        payload = { action: action, params: params }
        RestClient.post(url, payload.to_json, HEADERS)
      rescue Errno::ECONNREFUSED => ex
        puts "ERROR: Failed to connect to Anki Desktop at #{url}.".red
        puts '       Check to see that it is running wth the AnkiConnect plugin.'.red
        exit 1
      end
    end

    module JsonStringRefinement
      refine String do
        def parse_json
          JSON.parse(self)
        end
      end
    end
  end
end

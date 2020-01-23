require "webhookr"
require "webhookr-mailchimp/version"
require "active_support/core_ext/module/attribute_accessors"
require "webhookr/ostruct_utils"

module Webhookr
  module Mailchimp
    class Adapter
      SERVICE_NAME = 'mailchimp'
      EVENT_KEY = "type"
      PAYLOAD_KEY = "data"

      include Webhookr::Services::Adapter::Base

      def self.process(raw_response)
        new.process(raw_response)
      end

      def process(raw_response)
        Array.wrap(parse(raw_response)).collect do |p|
          Webhookr::AdapterResponse.new(
            SERVICE_NAME,
            p.fetch(EVENT_KEY),
            OstructUtils.to_ostruct(p)
          )
        end
      end

      private

      def parse(raw_response)
        assert_valid_packet(Rack::Utils.parse_nested_query(raw_response))
      end

      
      def assert_valid_packet(parsed_response)
        raise(Webhookr::InvalidPayloadError,
              "Missing event key '#{EVENT_KEY}' in packet"
        ) unless parsed_response[EVENT_KEY].present?

        raise(Webhookr::InvalidPayloadError,
              "No data key '#{PAYLOAD_KEY}' in the response"
        ) unless parsed_response[PAYLOAD_KEY].present?

        parsed_response
      end

    end

  end
end

# frozen_string_literal: true

require 'money-distributed'
require 'json'

class Money
  module Distributed
    module Fetcher
      # Currencylayer rates fetcher
      class Currencylayer
        include Base

        API_ENDPOINT = 'https://api.apilayer.com/currency_data/live?source=USD&currencies='

        def initialize(api_key, bank = nil)
          super(bank)
          @api_key = api_key
        end

        private

        def exchange_rates
          data = currency_data
          puts "currency data="
          puts JSON.pretty_generate(data)

          data['quotes'].each_with_object('USD' => 1) do |(code, rate), h|
            h[code[3, 3]] = BigDecimal(rate.to_s)
          end
        end

        def currency_data
          url = URI(API_ENDPOINT)
          https = Net::HTTP.new(url.host, url.port)

          https.use_ssl = true

          request = Net::HTTP::Get.new(url)

          request['apikey'] = @api_key
          response = https.request(request)

          JSON.parse(response.read_body)
        end
      end
    end
  end
end

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

        PROXY_IP = 'httpproxy-tcop.vip.ebay.com'
        PROXY_PORT = '80'

        def initialize(api_key, bank = nil)
          super(bank)
          @api_key = api_key
        end

        private

        def exchange_rates
          data = currency_data
          puts "currency data="
          data.each do |key, value|
            puts key + ' : ' + value
          end

          data['quotes'].each_with_object('USD' => 1) do |(code, rate), h|
            h[code[3, 3]] = BigDecimal(rate.to_s)
          end
        end

        def currency_data
          url = URI(API_ENDPOINT)

          # add proxy start
          proxy = Net::HTTP::Proxy(PROXY_IP, PROXY_PORT)
          response = proxy.start(url.hostname, url.port, :use_ssl => true) do |http|
            request = Net::HTTP::Get.new(url)
            request['apikey'] = @api_key
            http.request(request)
          end
          # add proxy end

          JSON.parse(response.read_body)
        end
      end
    end
  end
end

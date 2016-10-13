require 'money-distributed'
require 'json'

class Money
  module Distributed
    module Fetcher
      # Currencylayer rates fetcher
      class Currencylayer < Base
        API_ENDPOINT = 'http://apilayer.net/api/live'.freeze

        def initialize(api_key, bank = nil)
          super(bank)
          @api_key = api_key
        end

        private

        def exchange_rates
          url = "#{API_ENDPOINT}?access_key=#{@api_key}"
          data = JSON.parse(open(url).read)
          data['quotes'].each_with_object('USD' => 1) do |(code, rate), h|
            h[code[3, 3]] = BigDecimal.new(rate.to_s)
          end
        end
      end
    end
  end
end

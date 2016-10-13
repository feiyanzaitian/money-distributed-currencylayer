require 'rspec'
require 'webmock/rspec'
require 'money-distributed-currencylayer'

describe Money::Distributed::Fetcher::Currencylayer do
  let(:api_key) { 'loremapikey' }
  let(:bank) { double(add_rate: true) }

  subject { described_class.new(api_key, bank) }

  before do
    stub_request(
      :get,
      "#{described_class::API_ENDPOINT}?access_key=#{api_key}"
    ).to_return(
      status: 200,
      body: File.read(File.expand_path('../fixtures/response.json', __FILE__))
    )
  end

  it 'fetches rates from Currencylayer' do
    subject.fetch

    expect(bank).to have_received(:add_rate).with('USD', 'USD', 1.0)
    expect(bank).to have_received(:add_rate).with('AUD', 'AUD', 1.0)
    expect(bank).to have_received(:add_rate).with('EUR', 'EUR', 1.0)
    expect(bank).to have_received(:add_rate).with('USD', 'AUD', 1.3209)
    expect(bank).to have_received(:add_rate).with('AUD', 'USD', 0.7571)
    expect(bank).to have_received(:add_rate).with('USD', 'EUR', 0.9076)
    expect(bank).to have_received(:add_rate).with('EUR', 'USD', 1.1018)
    expect(bank).to have_received(:add_rate).with('AUD', 'EUR', 0.6871)
    expect(bank).to have_received(:add_rate).with('EUR', 'AUD', 1.4554)
  end
end

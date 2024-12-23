require 'rspec'
require_relative '../lib/checkout'
require_relative '../lib/pricing_rules/buy_one_get_one_free_rule'
require_relative '../lib/pricing_rules/bulk_discount_rule'
require_relative '../lib/pricing_rules/percentage_discount_rule'

RSpec.describe Checkout do
  let(:pricing_rules) do
    [
      PricingRules::BuyOneGetOneFreeRule.new('GR1'),
      PricingRules::BulkDiscountRule.new('SR1', 3, 4.50),
      PricingRules::PercentageDiscountRule.new('CF1', 3, 1.0/3.0)
    ]
  end

  let(:checkout) { Checkout.new(pricing_rules) }

  context 'test cases' do
    it 'calculates correct total for basket: GR1,SR1,GR1,GR1,CF1' do
      %w[GR1 SR1 GR1 GR1 CF1].each { |item| checkout.scan(item) }
      expect(checkout.total).to eq(22.45)
    end

    it 'calculates correct total for basket: GR1,GR1' do
      %w[GR1 GR1].each { |item| checkout.scan(item) }
      expect(checkout.total).to eq(3.11)
    end

    it 'calculates correct total for basket: SR1,SR1,GR1,SR1' do
      %w[SR1 SR1 GR1 SR1].each { |item| checkout.scan(item) }
      expect(checkout.total).to eq(16.61)
    end

    it 'calculates correct total for basket: GR1,CF1,SR1,CF1,CF1' do
      %w[GR1 CF1 SR1 CF1 CF1].each { |item| checkout.scan(item) }
      expect(checkout.total).to eq(30.57)
    end
  end

  context 'error handling' do
    it 'raises an error for invalid product code' do
      expect { checkout.scan('INVALID') }.to raise_error(ArgumentError)
    end
  end
end
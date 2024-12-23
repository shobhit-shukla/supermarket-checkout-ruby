#!/usr/bin/env ruby

require_relative 'lib/checkout'
require_relative 'lib/pricing_rules/buy_one_get_one_free_rule'
require_relative 'lib/pricing_rules/bulk_discount_rule'
require_relative 'lib/pricing_rules/percentage_discount_rule'

# Create pricing rules
pricing_rules = [
  PricingRules::BuyOneGetOneFreeRule.new('GR1'),
  PricingRules::BulkDiscountRule.new('SR1', 3, 4.50),
  PricingRules::PercentageDiscountRule.new('CF1', 3, 1.0/3.0)
]

# Test different baskets
def test_basket(items, pricing_rules)
  co = Checkout.new(pricing_rules)
  items.each { |item| co.scan(item) }
  puts "Basket: #{items.join(',')}"
  puts "Total: £#{co.total}"
  puts "---"
end

# Test all example baskets
puts "Testing example baskets:\n\n"

test_basket(%w[GR1 SR1 GR1 GR1 CF1], pricing_rules)
test_basket(%w[GR1 GR1], pricing_rules)
test_basket(%w[SR1 SR1 GR1 SR1], pricing_rules)
test_basket(%w[GR1 CF1 SR1 CF1 CF1], pricing_rules)

# Interactive mode
puts "\nInteractive mode (type 'done' to finish):"
co = Checkout.new(pricing_rules)
loop do
  print "Scan item (GR1/SR1/CF1): "
  input = gets.chomp
  break if input.downcase == 'done'

  begin
    co.scan(input)
    puts "Current total: £#{co.total}"
  rescue ArgumentError => e
    puts "Error: #{e.message}"
  end
end

puts "\nFinal total: £#{co.total}"

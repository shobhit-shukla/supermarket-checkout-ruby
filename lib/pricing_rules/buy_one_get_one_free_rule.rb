require_relative 'base_rule'

module PricingRules
  class BuyOneGetOneFreeRule < BaseRule
    def initialize(product_code)
      @product_code = product_code
    end

    # For each pair of items of the given product code, the second item is free.
    def apply(items)
      matching_items = items.select { |item| item.code == @product_code }
      free_items = matching_items.count / 2
      matching_items.first.price * (matching_items.count - free_items)
    end
  end
end

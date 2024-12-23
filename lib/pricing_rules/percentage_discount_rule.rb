require_relative 'base_rule'

module PricingRules
  class PercentageDiscountRule < BaseRule
    def initialize(product_code, minimum_quantity, discount_percentage)
      @product_code = product_code
      @minimum_quantity = minimum_quantity
      @discount_percentage = discount_percentage
    end

    # Discounted percentage is used When the quantity of the product code reaches the minimum quantity.
    def apply(items)
      matching_items = items.select { |item| item.code == @product_code }
      quantity = matching_items.count

      return 0 if quantity.zero?

      if quantity >= @minimum_quantity
        quantity * matching_items.first.price * (1 - @discount_percentage)
      else
        quantity * matching_items.first.price
      end
    end
  end
end

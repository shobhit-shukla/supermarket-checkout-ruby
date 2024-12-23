require_relative 'base_rule'

module PricingRules
  class BulkDiscountRule < BaseRule
    def initialize(product_code, minimum_quantity, discounted_price)
      @product_code = product_code
      @minimum_quantity = minimum_quantity
      @discounted_price = discounted_price
    end


    # When the quantity of the product code reaches the minimum quantity, the
    # discounted price is used. Otherwise, the regular price is used.
    def apply(items)
      matching_items = items.select { |item| item.code == @product_code }
      quantity = matching_items.count

      return 0 if quantity.zero?

      if quantity >= @minimum_quantity
        quantity * @discounted_price
      else
        quantity * matching_items.first.price
      end
    end
  end
end

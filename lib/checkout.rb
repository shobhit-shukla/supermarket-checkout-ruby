require_relative 'product'

class Checkout


  def initialize(pricing_rules)
    @pricing_rules = pricing_rules # Stores the pricing rules for the checkout.
    @items = [] # Stores the scanned items.
    @products = {
      'GR1' => Product.new('GR1', 'Green tea', 3.11),
      'SR1' => Product.new('SR1', 'Strawberries', 5.00),
      'CF1' => Product.new('CF1', 'Coffee', 11.23)
    } #   A hash mapping product codes to their respective Product objects.
  end

  # Scans an item and adds it to the checkout's items.
  def scan(item_code)
    product = @products[item_code]
    raise ArgumentError, "Invalid product code: #{item_code}" unless product
    @items << product
  end

  # Calculates the total price of all the items in the checkout.
  def total
    total = 0
    @pricing_rules.each do |rule|
      total += rule.apply(@items)
    end
    total.round(2)
  end
end

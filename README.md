# Supermarket Checkout System

A flexible checkout system implemented in Ruby that supports configurable pricing rules and special offers.

## Features

- Configurable pricing rules
- Multiple discount types:
  - Buy-one-get-one-free
  - Bulk discounts
  - Percentage discounts
- Error handling for invalid products
- Interactive command-line interface
- Comprehensive test suite

## Installation

1. Clone the repository
2. Install dependencies:
```bash
bundle install
```

## Usage

### Running Tests
```bash
rspec
```

### Interactive Mode
```bash
ruby run.rb
```

### Code Example
```ruby
# Create pricing rules
pricing_rules = [
  PricingRules::BuyOneGetOneFreeRule.new('GR1'),           # Green tea: Buy one get one free
  PricingRules::BulkDiscountRule.new('SR1', 3, 4.50),      # Strawberries: £4.50 each when buying 3+
  PricingRules::PercentageDiscountRule.new('CF1', 3, 1/3.0) # Coffee: 2/3 price when buying 3+
]

# Initialize checkout
co = Checkout.new(pricing_rules)

# Scan items
co.scan('GR1') # Green tea
co.scan('SR1') # Strawberries
co.scan('CF1') # Coffee

# Get total price
price = co.total
```

## Product Catalog

| Product Code | Name         | Unit Price |
|-------------|--------------|------------|
| GR1         | Green Tea    | £3.11      |
| SR1         | Strawberries | £5.00      |
| CF1         | Coffee       | £11.23     |

## Pricing Rules

### 1. Buy One Get One Free (GR1 - Green Tea)
- Buy one get one free
- Example: Two green teas cost £3.11

### 2. Bulk Discount (SR1 - Strawberries)
- Buy 3 or more strawberries
- Price drops to £4.50 each
- Regular price: £5.00 each

### 3. Percentage Discount (CF1 - Coffee)
- Buy 3 or more coffees
- Get 1/3 off price
- Regular price: £11.23 each
- Discounted: £7.49 each

## Example Baskets

| Items                    | Total  | Explanation                                    |
|-------------------------|--------|------------------------------------------------|
| GR1,SR1,GR1,GR1,CF1    | £22.45 | 2×GR1 (BOGOF), 1×SR1, 1×CF1                  |
| GR1,GR1                 | £3.11  | 2×GR1 (BOGOF)                                 |
| SR1,SR1,GR1,SR1        | £16.61 | 3×SR1 (bulk discount), 1×GR1                  |
| GR1,CF1,SR1,CF1,CF1    | £30.57 | 1×GR1, 3×CF1 (percentage discount), 1×SR1     |

## Project Structure

```
.
├── lib/
│   ├── checkout.rb                      # Main checkout logic
│   ├── product.rb                       # Product class
│   └── pricing_rules/                   # Pricing rule implementations
│       ├── base_rule.rb
│       ├── buy_one_get_one_free_rule.rb
│       ├── bulk_discount_rule.rb
│       └── percentage_discount_rule.rb
├── spec/
│   └── checkout_spec.rb                 # Test suite
├── run.rb                              # Interactive CLI
├── Gemfile                             # Dependencies
└── README.md
```

require_relative '../test_helper'
require_relative '../../lib/checkout'
require_relative '../../lib/pricing_rule'
require_relative '../../models/product'

describe Checkout do
  # seeds the database
  Product.create(product_code: 'GR1', name: 'Green tea', price: '3.11')
  Product.create(product_code: 'SR1', name: 'Strawberries', price: '5.00')
  Product.create(product_code: 'CF1', name: 'Coffee', price: '11.23')

  rules = {
    GR1: proc { |total, price| total / 2 * price + total % 2 * price },
    SR1: proc { |total, price|
      total >= 3 ? total * (price - price * 0.1) : total * price
    }
  }
  pricing_rule = PricingRule.new(rules)

  it 'with the next basket (GR1,SR1,GR1,GR1,CF1) should return 22.45' do
    co = Checkout.new pricing_rule
    %w[GR1 SR1 GR1 GR1 CF1].each do |item|
      co.scan item
    end

    expect(co.total).to eq 22.45
  end

  it 'with the next basket (GR1,GR1) should return 3.11' do
    co = Checkout.new pricing_rule
    %w[GR1 GR1].each do |item|
      co.scan item
    end

    expect(co.total).to eq 3.11
  end

  it 'the next basket (SR1,SR1,GR1,SR1) should return 16.61' do
    co = Checkout.new pricing_rule
    %w[SR1 SR1 GR1 SR1].each do |item|
      co.scan item
    end

    expect(co.total).to eq 16.61
  end
end

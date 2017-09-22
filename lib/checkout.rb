class Checkout
  attr_accessor :basket, :pricing_rule

  def initialize(pricing_rule)
    unless pricing_rule.is_a? PricingRule
      raise 'The first params must be an instance of PricingRule'
    end
    @basket = {}
    @pricing_rule = pricing_rule
  end

  # ideal case, if the product_code doesnt exist in products just add
  # not good,
  # I think you should add a product_code to the basket only if it exist
  def scan(item)
    product_code = (item.is_a? Product) ? item.product_code : item
    if @basket[product_code].nil?
      @basket[product_code] = 1
    else
      @basket[product_code] += 1
    end
  end

  def total
    total_price = 0
    @basket.each do |product_key, total|
      # The ideal case when the product exist and
      # if it doesnt exit just ignore that case
      # not good, it have been done on purpose but I should do something
      if product = Product.find_by(product_code: product_key)
        if @pricing_rule.rules[product_key.to_sym].nil?
          total_price += product.price * total
        else
          total_price += @pricing_rule.rules[product_key.to_sym]
                                      .call(total, product.price)
        end
      end
    end
    total_price
  end
end

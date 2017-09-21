class PricingRule
  attr_accessor :rules

  def initialize(rules)
    validate_rule!(rules)
    @rules = rules
  end

  def validate_rule!(rules)
    raise 'must be a Hash' unless rules.is_a? Hash
    rules.each do |_key, value|
      unless value.is_a? Proc
        raise 'must be a Hash and the values must be procs'
      end
    end
  end
end

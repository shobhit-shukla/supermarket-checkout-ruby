module PricingRules
  class BaseRule
    def apply(items)
      raise NotImplementedError, "#{self.class} must implement #apply"
    end
  end
end
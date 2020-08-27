class Price
  include Mongoid::Document
  field :discount_value, type: Float
  field :value, type: Float
  field :benefit_tier, type: String
  belongs_to :ticket
end

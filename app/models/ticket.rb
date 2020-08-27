class Ticket
  include Mongoid::Document

  field :label, type: String
  belongs_to :product
  has_many :prices, dependent: :destroy
end

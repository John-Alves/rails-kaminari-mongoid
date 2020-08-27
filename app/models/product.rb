class Product
  include Mongoid::Document
  field :name, type: String

  has_many :tickets, dependent: :destroy

  def self.sort_by_biggest_discounts
    ascending = -1

    clookup = [
      {
        '$lookup': {
          'from': "tickets",
          'localField': "_id",
          'foreignField': "product_id",
          'as': "tickets"
        }
      },
      { '$unwind': '$tickets' },
      {
        '$lookup': {
          'from': "prices",
          'localField': "tickets._id",
          'foreignField': "ticket_id",
          'as': "prices"
        }
      },
      { '$unwind': '$prices' },
      {
        '$sort': {
          'prices.discount_value': ascending
        }
      },
      {
        '$group': {
            "_id": "$_id",
            "name": { "$first": "$name" },
            "discount_value": { "$first": "$prices.discount_value" }
        }
      },
      {
        '$sort': {
            'discount_value': ascending
        }
      },
    ].as_json

    docs = where({}).collection.aggregate(clookup)
    ids = docs.map { |doc| doc['_id'] }.uniq
    id_indices = Hash[ids.map.with_index { |id,idx| [id,idx] }]
    Product.find(ids).sort_by { |product| id_indices[product.id] }
  end
end

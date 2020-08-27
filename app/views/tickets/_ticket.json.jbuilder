json.extract! ticket, :id, :product_id, :prices, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)

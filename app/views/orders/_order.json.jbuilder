json.extract! order, :id, :deadline, :total, :payment_type, :order_hash, :address_id, :user_id, :establishment_id, :created_at, :updated_at
json.url order_url(order, format: :json)

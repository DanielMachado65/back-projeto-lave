class OrderSerializer < ActiveModel::Serializer
  attributes :id, :deadline, :total, :payment_type, :order_hash
  has_one :address
  has_one :user
  has_one :establishment
end

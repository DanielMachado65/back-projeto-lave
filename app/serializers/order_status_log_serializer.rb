class OrderStatusLogSerializer < ActiveModel::Serializer
  attributes :id
  has_one :order
  has_one :order_status
end

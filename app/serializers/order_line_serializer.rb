class OrderLineSerializer < ActiveModel::Serializer
  attributes :id
  has_one :product
  has_one :order
end

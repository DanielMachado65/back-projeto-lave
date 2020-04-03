class OrderLineSerializer < ActiveModel::Serializer
  attributes :id
  
  has_one :product
end

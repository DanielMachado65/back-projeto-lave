class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description,:price, :is_active

  has_one :establishment
  has_one :category
end

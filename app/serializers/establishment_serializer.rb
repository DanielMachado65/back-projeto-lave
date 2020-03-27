class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :fantasy_name, :has_delivery, :phone

  has_one :address
  has_one :user
end

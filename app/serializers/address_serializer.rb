class AddressSerializer < ActiveModel::Serializer
  attributes :street, :city, :country, :number, :state, :zip_code
end

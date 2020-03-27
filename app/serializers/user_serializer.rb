class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :telephone, :auth_token

  has_one :address
end

class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :telephone
end

class EstablishmentSerializer < ActiveModel::Serializer
  attributes :name, :fantasy_name, :has_delivery, :phone, :address, :user

  def address
    object.address.as_json(except: [:id, :created_at, :updated_at])
  end

  def user
    object.user.as_json(only: [:name, :email, :telephone])
  end
end

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description,:price, :is_active,:establishment, :category

  def establishment
    object.establishment.as_json(except: %I[id created_at updated_at])
  end

  def category
    object.category.as_json(except: %I[id created_at updated_at])
  end
end

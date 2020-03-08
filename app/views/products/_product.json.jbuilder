json.extract! product, :id, :establishment_id, :category_id, :price, :name, :description, :is_active, :created_at, :updated_at
json.url product_url(product, format: :json)

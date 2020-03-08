class Product < ApplicationRecord
  belongs_to :establishment
  belongs_to :category
end

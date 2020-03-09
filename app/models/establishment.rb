class Establishment < ApplicationRecord
  belongs_to :address
  belongs_to :user

  has_many :products
end

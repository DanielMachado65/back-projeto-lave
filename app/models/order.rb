class Order < ApplicationRecord
  belongs_to :address
  belongs_to :user
  belongs_to :establishment
end

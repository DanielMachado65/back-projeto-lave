class Address < ApplicationRecord
  has_one :establishment
  has_one :user
end

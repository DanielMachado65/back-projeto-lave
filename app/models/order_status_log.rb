class OrderStatusLog < ApplicationRecord
  belongs_to :order
  belongs_to :order_status
end

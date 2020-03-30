class OrderSerializer < ActiveModel::Serializer
  attributes :id, :deadline, :payment_type, :order_hash, :total
  
  has_one :address
  has_one :user
  has_one :establishment

  has_many :order_status
  has_many :order_lines

  def total
    object.get_total
  end
end

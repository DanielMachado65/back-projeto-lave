class OrderSerializer < ActiveModel::Serializer
  attributes :id, :deadline, :payment_type, :order_hash, :total, :orders_lines
  
  has_one :address
  has_one :user
  has_one :establishment

  has_many :order_status

  def total
    object.get_total
  end

  # hack: thing about return only uniq products
  def orders_lines
    ActiveModel::SerializableResource.new(object.order_lines, each_serializer: OrderLineSerializer)
  end
end

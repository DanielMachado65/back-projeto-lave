# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :address
  belongs_to :user
  belongs_to :establishment

  has_many :order_status_logs
  has_many :order_status, through: :order_status_logs

  has_many :order_lines. dependent: :destroy
  has_many :products, through: :order_lines

  after_create :create_order_status
  before_create :generate_hash

  def get_total
    products.sum(:price)
  end

  def generate_hash
    self.order_hash = [*('A'..'Z'), *('0'..'9')].sample(8).join
  end

  private

  def create_order_status
    self.order_status << OrderStatus.created
  end
end

# frozen_string_literal: true

class OrderStatus < ApplicationRecord
  has_many :order_status_logs, dependent: :destroy
  has_many :orders, through: :order_status_logs

  validates :name, presence: true

  def self.created
    find_by(name: 'Criado')
  end
end

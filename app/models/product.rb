# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :establishment
  belongs_to :category

  has_many :order_lines
  has_many :orders, through: :order_lines
end

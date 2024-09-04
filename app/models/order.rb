class Order < ApplicationRecord
  validates :product_name, presence: true, format: { with: /\A[a-z\-' ]+\z/i }
  validates :product_count, presence: true, numericality: { only_integer: true }
  validates :customer_id, presence: true

  belongs_to :customer
end

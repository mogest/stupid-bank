class Txn < ApplicationRecord
  belongs_to :account

  scope :ordered, -> { order(:transaction_at => :desc) }

  validates :transaction_at, :description, :amount, presence: true
  validates :description, length: {maximum: 32}
end

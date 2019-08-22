class Account < ApplicationRecord
  belongs_to :user
  has_many :txns, dependent: :destroy

  validates :account_number, :description, :balance, presence: true

  def balance
    txns.sum(:amount)
  end
end

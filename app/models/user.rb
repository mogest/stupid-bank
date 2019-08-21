class User < ApplicationRecord
  validates :name, presence: true
  validates :pin, format: {with: /\A[0-9]{4,8}\z/, message: 'must be a four to eight digit number'}
end

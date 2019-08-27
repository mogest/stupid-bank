class Message < ApplicationRecord
  belongs_to :user

  validates :subject, :body, presence: true
end

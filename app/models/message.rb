class Message < ApplicationRecord
  belongs_to :consultation
  belongs_to :user
  validates :content, length: { minimum: 1 }, presence: true
end

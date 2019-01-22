class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, presence: true
  validates :user, presence: true
  validates :address, presence: true
  validates :telephone, presence: true
end

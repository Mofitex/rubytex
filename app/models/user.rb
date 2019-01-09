class User < ApplicationRecord
  has_many :comments
  has_many :restaurants

  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true
  validates :admin, :inclusion => {:in => [true, false]}
end

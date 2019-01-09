class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :title, presence: true
  validates :text, presence: true
  validates :score, presence: true
  validates :user, presence: true
end

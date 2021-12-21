class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :genre
  belongs_to :user
  has_one_attached :image

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  validates :title, presence: true
  validates :text, presence: true
  validates :genre_id, numericality: { other_than: 0, message: " を選択してください" }
end

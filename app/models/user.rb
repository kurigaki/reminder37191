class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,32}+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'が無効です。文字と数字の両方を含んでください'

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end

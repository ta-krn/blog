class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_articles, through: :likes, source: :article
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
end
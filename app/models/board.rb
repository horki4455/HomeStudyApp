class Board < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validates :title, length: { maximum: 225 }, presence: true
  validates :body, length: { maximum: 65_535 }, presence: true
end
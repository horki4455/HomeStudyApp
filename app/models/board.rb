class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
  
  validates :name, length: { maximum: 225 }, presence: true

  def board_user_name 
    "#{name}"
  end
end

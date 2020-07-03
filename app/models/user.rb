class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :first_name, presence: true, length: { maximum: 55 }
  validates :last_name, presence: true, length: { maximum: 55 }
  enum role: { general: 0, admin: 1 }

  def full_name
    "#{last_name} #{first_name}"
  end

  def own?(object)
    id == object.user_id
  end
end

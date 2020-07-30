class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy 
  has_many :followers, through: :reverse_of_relationships, source: :follower#user
  has_many :students, dependent: :destroy
  has_many :memos, dependent: :destroy 

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

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def matchers(other_user)
    following? & followers
  end
end

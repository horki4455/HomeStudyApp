class Student < ApplicationRecord
    belongs_to :user
    has_many :memos, dependent: :destroy
    mount_uploader :image, ImageUploader
end

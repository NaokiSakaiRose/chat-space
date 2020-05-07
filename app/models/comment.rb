class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :comment, presence: true, unless: :image?

  mount_uploader :image, ImageUploader
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_users
  has_many :groups, through: :group_users
  has_many :contents

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true, uniqueness: true
  # 半角英数字のみ許可_パスワード
  # VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  # validates :encrypted_password, format: { with: VALID_PASSWORD_REGEX }
end

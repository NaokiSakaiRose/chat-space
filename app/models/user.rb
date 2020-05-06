class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true, uniqueness: true
  # 半角英数字のみ許可_パスワード
  # VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  # validates :encrypted_password, format: { with: VALID_PASSWORD_REGEX }
end

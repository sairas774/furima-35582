class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,           presence: true, length: { maximum: 40 }
  validates :first_name,         presence: true,
                                 format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name,          presence: true,
                                 format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name_kana,    presence: true,
                                 format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :last_name_kana,     presence: true,
                                 format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birth_day,          presence: true
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i

  has_many :items
end

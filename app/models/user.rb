class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Password Include both letters and numbers'
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' } do
    validates :family_name
    validates :first_name
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width characters' } do
    validates :family_name_kana
    validates :first_name_kana
  end
  validates :birthday, presence: true

  has_many :items
  has_many :purchases
  has_many :messages
end

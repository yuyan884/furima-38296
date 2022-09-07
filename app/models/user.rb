class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association
  has_many  :items
  has_many  :histories

  VALID_YEAR_REGEX = /\A19[3-9][0-9][-]\d{2}[-]\d{2}|#{(Time.now.year-5).to_s[0]}#{(Time.now.year-5).to_s[1]}[0-#{(Time.now.year-5).to_s[2]}][0-#{(Time.now.year-5).to_s[3]}][-]\d{2}[-]\d{2}\z/

  validates :nickname,        presence: true
  validates :password,                        format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'Password is invalid. Include both letters and numbers'}
  validates :last_name,       presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'Input full-width characters'}
  validates :first_name,      presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'Input full-width characters'}
  validates :last_name_kana,  presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'Input full-width katakana characters'}
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'Input full-width katakana characters'}
  validates :birthday,        presence: true
end

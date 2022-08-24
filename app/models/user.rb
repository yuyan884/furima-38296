class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password,        format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'Password is invalid. Include both letters and numbers'}
  validates :last_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々]\z/, message: 'Input full-width characters'}
  validates :first_name,      format: { with: /\A[ぁ-んァ-ヶ一-龥々]\z/, message: 'Input full-width characters'}
  validates :last_name_kana,  format: { with: /\A[ァ-ヶー]+\z/, message: 'Input full-width katakana characters'}
  validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'Input full-width katakana characters'}
  validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'Input full-width katakana characters'}
  validates :birthday,        format: { with: /\A\d{4}[-]\d{2}[-]\d{2}\z/, message: "can't be blank"}
end

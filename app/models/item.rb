class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # Definitions
  include ValidationDefinition

  # Association
  belongs_to       :user          # Userモデル
  has_one_attached :image         # ActiveStorage
  belongs_to       :category      # ActiveHash
  belongs_to       :condition     # ActiveHash
  belongs_to       :shipping_fee  # ActiveHash
  belongs_to       :prefecture    # ActiveHash
  belongs_to       :days_delivery # ActiveHash
  has_one          :history       # Historyモデル

  # Validation
  validates :name,             presence: true, length: {maximum: MAX_NAME_LENGTH   }
  validates :detail,           presence: true, length: {maximum: MAX_DETAIL_LENGTH }
  validates :category_id,      numericality: { greater_than: BLANK_MENU, less_than: Category.data.length,     message: "を入力してください" }
  validates :condition_id,     numericality: { greater_than: BLANK_MENU, less_than: Condition.data.length,    message: "を入力してください" }
  validates :shipping_fee_id,  numericality: { greater_than: BLANK_MENU, less_than: ShippingFee.data.length,  message: "を入力してください" }
  validates :prefecture_id,    numericality: { greater_than: BLANK_MENU, less_than: Prefecture.data.length,   message: "を入力してください" }
  validates :days_delivery_id, numericality: { greater_than: BLANK_MENU, less_than: DaysDelivery.data.length, message: "を入力してください" }
  validates :price,            numericality: { only_integer: true, message: 'は半角数字で入力してください' }
  validates :price,            numericality: { greater_than_or_equal_to: MIN_PRICE, less_than_or_equal_to: MAX_PRICE, message: "は¥300〜9,999,999の範囲で入力してください" }
  validates :image,            presence: true
end

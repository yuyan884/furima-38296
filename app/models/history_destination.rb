class HistoryDestination
  include ActiveModel::Model

  # Association
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :house_number, :building_name, :phone_number, :history_id, :token

  # Definitions
  include ValidationDefinition

  # Validations
  with_options presence: true do
    validates :postcode,      format: { with: POSTCODE_REGEX,    message: "が不正です。123-4567のように入力してください。" }
    validates :city
    validates :house_number
    validates :phone_number,  format: { with: PHONENUMBER_REGEX, message: "が不正です。数字のみを入力してください。" }
    validates :token
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { greater_than: BLANK_MENU, less_than: Prefecture.data.length, message: "を入力してください" }

  # Methods
  def save
    # 購入履歴の保存
    history = History.create(user_id: user_id, item_id: item_id)
    # 配送先の保存
    destination = Destination.create(
      postcode:      postcode,
      prefecture_id: prefecture_id,
      city:          city,
      house_number:  house_number,
      building_name: building_name,
      phone_number:  phone_number,
      history_id:    history.id
    )
  end
end
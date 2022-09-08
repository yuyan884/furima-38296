FactoryBot.define do
  factory :history_destination do
    # 定数
    BLANK_MENU = 0 # プルダウンメニュー: '---'
    # ダミーデータ
    postcode      {Faker::Address.postcode}
    prefecture_id {Faker::Number.between(from: (BLANK_MENU+1), to: (Prefecture.count-1))}
    city          {Faker::Address.city}
    house_number  {Faker::Address.street_address}
    building_name {Faker::Address.building_number}
    phone_number  {Faker::PhoneNumber.subscriber_number(length: 11)}
    token         {"tok_abcdefghijk00000000000000000"}
  end
end

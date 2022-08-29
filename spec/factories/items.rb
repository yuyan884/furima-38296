FactoryBot.define do
  factory :item do
    # 定数
    MAX_NAME_LENGTH   = 40      # 商品名の最大文字数
    MAX_DETAIL_LENGTH = 1000    # 商品説明の最大文字数
    BLANK_MENU        = 0       # プルダウンメニュー: '---'
    MIN_PRICE         = 300     # 設定可能な最低販売価格
    MAX_PRICE         = 9999999 # 設定可能な最高販売価格
    # ダミーデータ
    name          {Faker::Base.regexify("[あ]{#{MAX_NAME_LENGTH}}")}#{Faker::Commerce.product_name}
    detail        {Faker::Base.regexify("[あ]{#{MAX_DETAIL_LENGTH}}")}#{Faker::Lorem.paragraph}
    category      {Category.where(id: (BLANK_MENU+1)..Category.count).sample}
    condition     {Condition.where(id: (BLANK_MENU+1)..Condition.count).sample}
    shipping_fee  {ShippingFee.where(id: (BLANK_MENU+1)..ShippingFee.count).sample}
    prefecture    {Prefecture.where(id: (BLANK_MENU+1)..Prefecture.count).sample}
    days_delivery {DaysDelivery.where(id: (BLANK_MENU+1)..DaysDelivery.count).sample}
    price         {Faker::Commerce.price(range: MIN_PRICE..MAX_PRICE)}
    association   :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
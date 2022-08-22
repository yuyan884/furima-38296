# README

## Database design

### "users" table

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |
| nickname           | string     | null: false                    |
| first_name         | string     | null: false                    |
| last_name          | string     | null: false                    |
| first_name_kana    | string     | null: false                    |
| last_name_kana     | string     | null: false                    |
| birthday           | date       | null: false                    |

#### Association
- has_many :items
- has_many :historys

### "items" table

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| detail             | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_fee_id    | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| days_delivery_id   | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

#### Association
- belongs_to :users
- has_one    :historys

#### Notes

* category_id
  * 0: ---
  * 1: レディース
  * 2: メンズ
  * 3: ベビー・キッズ
  * 4: インテリア・住まい・小物
  * 5: 本・音楽・ゲーム
  * 6: おもちゃ・ホビー・グッズ
  * 7: 家電・スマホ・カメラ
  * 8: スポーツ・レジャー
  * 9: ハンドメイド
  * 10: その他
* condition_id
  * 0: ---
  * 1: 新品・未使用
  * 2: 未使用に近い
  * 3: 目立った傷や汚れなし
  * 4: やや傷や汚れあり
  * 5: 傷や汚れあり
  * 6: 全体的に状態が悪い
* shipping_fee_id
  * 0: ---
  * 1: 着払い(購入者負担)
  * 2: 送料込み(出品者負担)
* prefecture_id
  * 0: ---
  * 1: 北海道
  * ...
  * 47: 沖縄県
* days_delivery_id
  * 0: ---
  * 1: 1~2日で発送
  * 2: 2~3日で発送
  * 3: 4~7日で発送

### "historys" table

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

#### Association
- belongs_to :users
- belongs_to :items
- has_one    :destinations

### "destinations" table

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postcode           | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| house_number       | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | string     | null: false                    |
| history            | references | null: false, foreign_key: true |

#### Association
- belongs_to :historys

#### Notes

* prefecture_id
  * 0: ---
  * 1: 北海道
  * ...
  * 47: 沖縄県
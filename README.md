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

### "items" table

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| detail             | text       | null: false                    |
| category           | integer    | null: false                    |
| condition          | integer    | null: false                    |
| shipping_fee       | integer    | null: false                    |
| source_pref        | integer    | null: false                    |
| days_delivery      | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

#### Notes

* category
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
* condition
  * 0: ---
  * 1: 新品・未使用
  * 2: 未使用に近い
  * 3: 目立った傷や汚れなし
  * 4: やや傷や汚れあり
  * 5: 傷や汚れあり
  * 6: 全体的に状態が悪い
* shipping_burden
  * 0: ---
  * 1: 着払い(購入者負担)
  * 2: 送料込み(出品者負担)
* source_pref
  * 0: ---
  * 1: 北海道
  * ...
  * 47: 沖縄県
* days_delivery
  * 0: ---
  * 1: 1~2日で発送
  * 2: 2~3日で発送
  * 3: 4~7日で発送

### "destinations" table

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postcode           | integer    | null: false                    |
| prefecture         | integer    | null: false                    |
| city               | string     | null: false                    |
| house_number       | string     | null: false                    |
| building_name      | string     |                                |
| phone_number       | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

#### Notes

* destination_pref
  * 0: ---
  * 1: 北海道
  * ...
  * 47: 沖縄県
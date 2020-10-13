@@ -1,6 +1,6 @@
# テーブル設計

## Users テーブル
| Column           | Type    | Options                        |
| ---------------- | ------- | ------------------------------ |
| nickname         | string  | null: false                    |
| email            | string  | null: false                    |
| password         | string  | null: false                    |
| family_name      | string  | null: false                    |
| first_name       | string  | null: false                    |
| family_name_kana | string  | null: false                    |
| first_name_kana  | string  | null: false                    |
| birthday         | date    | null: false                    |

### Association

- has_many :items
- has_many :purchases

## Items テーブル

| Column             | Type      | Options                        |
| ------------------ | --------- | ------------------------------ |
| name               | string    | null: false                    |
| text               | text      | null: false                    |
| price              | integer   | null: false                    |
| user               | reference | null: false, foreign_key: true |
| category_id        | integer   | null: false                    |
| condition_id       | integer   | null: false                    |
| shipping_format_id | integer   | null: false                    |
| day_id             | integer   | null: false                    |
| prefecture_id      | integer   | null: false                    |

### Association

- belongs_to :user
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :shipping_format
- belongs_to_active_hash :day
- belongs_to_active_hash :prefecture
- has_one :purchase

## Orders テーブル

| column        | Type      | Options                        |
| --------------| --------- | ------------------------------ |
| postal_code   | string    | null: false                    |
| prefecture_id | string    | null: false                    |
| municipality  | string    | null: false                    |
| address       | string    | null: false                    |
| building_name | string    |                                |
| phone_number  | string    | null: false                    |
| purchase      | reference | null: false, foreign_key: true |

### Association

- belongs_to :purchase
- belongs_to_active_hash :prefecture

## Purchases テーブル

| Column | Type      | Options                        |
| ------ | --------- | ------------------------------ |
| user   | reference | null: false, foreign_key: true |
| item   | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :order
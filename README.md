# テーブル設計

## users テーブル

| Column                 | Type   | Options                   |
| ---------------------- | ------ | ------------------------- |
| nickname               | string | null: false               |
| email                  | string | null: false, unique: true |
| encrypted_password     | string | null: false               |
| first_name             | string | null: false               |
| last_name              | string | null: false               |
| first_name(kana)       | string | null: false               |
| last_name(kana)        | string | null: false               |
| birth_day              | date   | null: false               |

### Association

- has_many :items
- has_many :purchase_records

## items テーブル

| Column              | Type       | Options           |
| ------------------- | ---------- | ----------------- |
| name                | string     | null: false       |
| description_of_item | text       | null: false       |
| category_id         | integer    | null: false       |
| items_condition_id  | integer    | null: false       |
| shipping_charge_id  | integer    | null: false       |
| shipping_area_id    | integer    | null: false       |
| days_to_ship_id     | integer    | null: false       |
| price               | integer    | null: false       |
| user                | references | foreign_key: true |


### Association

- belongs_to :users
- has_one :purchase_records

## shipping_address テーブル

| Column           | Type          | Options           |
| ---------------- | ------------- | ----------------- |
| postal_code      | string        | null: false       |
| shipping_area_id | integer       | null: false       |
| municipality     | string        | null: false       |
| address          | bigint        | null: false       |
| building_name    | references    | foreign_key: true |
| phone_number     | bigint        | null: false       |

### Association

- has_one :purchase_records
- belongs_to :purchase_records

## purchase_records テーブル

| Column           | Type          | Options           |
| ---------------- | ------------- | ----------------- |
| item             | references    | foreign_key: true |
| user             | references    | foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- belongs_to :shipping_addresses
# テーブル設計

## users テーブル

| Column                 | Type   | Options                   |
| ---------------------- | ------ | ------------------------- |
| nickname               | string | null: false               |
| email                  | string | null: false, unique: true |
| encrypted_password     | string | null: false               |
| first_name             | string | null: false               |
| last_name              | string | null: false               |
| first_name_kana        | string | null: false               |
| last_name_kana         | string | null: false               |
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

- belongs_to :user
- has_one :purchase_record

## shipping_addresses テーブル

| Column           | Type          | Options           |
| ---------------- | ------------- | ----------------- |
| postal_code      | string        | null: false       |
| shipping_area_id | integer       | null: false       |
| municipality     | string        | null: false       |
| address          | string        | null: false       |
| building_name    | string        |                   |
| phone_number     | string        | null: false       |
| purchase_record  | references    | foreign_key: true |

### Association

- belongs_to :purchase_record

## purchase_records テーブル

| Column           | Type          | Options           |
| ---------------- | ------------- | ----------------- |
| item             | references    | foreign_key: true |
| user             | references    | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address
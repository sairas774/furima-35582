# テーブル設計

## user テーブル

| Column                 | Type   | Options      |
| ---------------------- | ------ | ------------ |
| nickname               | string | null: false  |
| email                  | string | unique: true |
| encrypted_password     | string | null: false  |
| first_name             | string | null: false  |
| last_name              | string | null: false  |
| first_name(kana)       | string | null: false  |
| last_name(kana)        | string | null: false  |
| birth_day              | date   | null: false  |

### Association

- has_many :items
- has_many :purchase_record

## items テーブル

| Column              | Type      | Options           |
| ------------------- | --------- | ----------------- |
| name                | string    | null: false       |
| description_of_item | text      | null: false       |
| category_id         | integer   | null: false       |
| items_condition_id  | integer   | null: false       |
| shipping_charge_id  | integer   | null: false       |
| shipping_area_id    | integer   | null: false       |
| days_to_ship_id     | integer   | null: false       |
| price               | integer   | null: false       |
| user_id             | reference | foreign_key: true |


### Association

- belongs_to :user
- has_one :purchase_record

## shipping_address テーブル

| Column         | Type          | Options           |
| -------------- | ------------- | ----------------- |
| postal_code    | string        | null: false       |
| prefectures    | string        | null: false       |
| municipality   | string        | null: false       |
| address        | bigint        | null: false       |
| building_name  | string        |                   |
| phone_number   | bigint        | null: false       |

### Association

- has_one :purchase_record

## purchase_record テーブル

| Column           | Type          | Options           |
| ---------------- | ------------- | ----------------- |
| what_I_bought_id | reference     | foreign_key: true |
| user_id          | reference     | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :items
- belongs_to :shipping_address
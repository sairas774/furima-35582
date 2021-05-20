# テーブル設計

## user テーブル

| Column                 | Type   | Options     |
| ---------------------- | ------ | ----------- |
| nickname               | string | null: false |
| email                  | string | null: false |
| password               | string | null: false |
| password(verification) | string | null: false |
| first_name             | string | null: false |
| last_name              | string | null: false |
| first_name             | string | null: false |
| last_name              | string | null: false |
| birth_day              | date   | null: false |

### Association

- has_many :items
- has_many :shipping_address
- has_many :purchase_record

## items テーブル

| Column                   | Type          | Options           |
| ------------------------ | ------------- | ----------------- |
| name                     | string        | null: false       |
| description_of_item      | text          | null: false       |
| category                 | string        | null: false       |
| items_condition          | string        | null: false       |
| shipping_charges         | string        | null: false       |
| shipping_area            | string        | null: false       |
| days_to_ship             | string        | null: false       |
| price                    | integer       | null: false       |


### Association

- has_one :shipping_address
- belongs_to :product_information
- has_one :purchase_record

## shipping_address テーブル

| Column         | Type          | Options           |
| -------------- | ------------- | ----------------- |
| postal_code    | string        | null: false       |
| prefectures    | string        | null: false       |
| municipality   | string        | null: false       |
| address        | bigint        | null: false       |
| building_name  | string        | null: false       |
| phone_number   | bigint        | null: false       |

### Association

- belongs_to :user
- has_one :shipping_address
- has_one :purchase_record

## purchase_record テーブル

| Column        | Type          | Options           |
| ------------- | ------------- | ----------------- |
| what_I_bought | reference     | foreign_key: true |
| user          | reference     | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :items
- belongs_to :shipping_address
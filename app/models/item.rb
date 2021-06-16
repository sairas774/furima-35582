class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached       :image
  belongs_to             :user
  has_one                :purchase

  with_options presence: true do
    validates :image
    validates :name
    validates :description_of_item
    validates :category
    validates :items_condition
    validates :shipping_charge
    validates :shipping_area
    validates :days_to_ship
    validates :price, inclusion: { in: 300..9_999_999 },
                      format: { with: /\A[0-9]+\z/ }
  end

  belongs_to_active_hash :category
  belongs_to_active_hash :items_condition
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship

  validates :category_id, :items_condition_id, :shipping_charge_id,
            :shipping_area_id, :days_to_ship_id, numericality: { other_than: 0 , message: 'の入力は選択肢より選んでください'}
  validates :price, numericality: true
end

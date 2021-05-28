class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached       :image

  with_options presence: true do
    validates :name
    validates :description_of_item
    validates :category
    validates :items_condition
    validates :shipping_charge
    validates :shipping_area
    validates :days_to_ship
    validates :price
  end

  belongs_to_active_hash :category
  belongs_to_active_hash :items_condition
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :days_to_ship

  validates :category_id, :items_condition_id, :shipping_charge_id,
            :shipping_area_id, :days_to_ship_id, numericality: { other_than: 1 }
end

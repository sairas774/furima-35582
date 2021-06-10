class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_area_id, :municipality, :address, :building_name, :phone_number, :item_id, :user_id,
                :token

  with_options presence: true do
    validates :postal_code,      format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :shipping_area_id, numericality: { other_than: 0 }
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
    validates :item_id
    validates :user_id
    validates :token
  end

  def save
    @purchase = Purchase.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(postal_code: postal_code, shipping_area_id: shipping_area_id, municipality: municipality,
                           address: address, building_name: building_name, phone_number: phone_number, purchase_id: @purchase.id)
  end
end

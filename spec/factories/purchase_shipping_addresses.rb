FactoryBot.define do
  factory :purchase_shipping_address do
    postal_code        { "123-4567" }
    shipping_area_id   { 1 }
    municipality       { "札幌市北区" }
    address            { "北８−５" }
    building_name      { "門倉ビル３０１" }
    phone_number       { "08034567890" }
    association :user
    association :item
  end
end
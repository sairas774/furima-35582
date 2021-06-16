FactoryBot.define do
  factory :item do
    name                { '名前' }
    description_of_item { '説明' }
    category_id         { 1 }
    items_condition_id  { 1 }
    shipping_charge_id  { 1 }
    shipping_area_id    { 1 }
    days_to_ship_id     { 1 }
    price               { 2000 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample_image.png'), filename: 'sample_image.png')
    end
  end
end

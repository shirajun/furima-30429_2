FactoryBot.define do
  factory :purchase_order do
    postal_code { '111-1111' }
    prefecture_id { 2 }
    municipality { 'test' }
    address { '111' }
    building_name { '' }
    phone_number { '09012345678'}
    price { 3000 }

    association :user, :item
  end
end

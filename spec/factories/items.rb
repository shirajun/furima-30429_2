FactoryBot.define do
  factory :item do
    name               { "test" }
    text               { "test" }
    category_id           { 2 }
    condition_id          { 2 }
    shipping_format_id    { 2 }
    prefecture_id         { 2 }
    day_id                { 2 }
    price              { 9999999 }
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    association :user
  end
end

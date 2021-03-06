FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    password { 'abc123' }
    password_confirmation { 'abc123' }
    transient do
      person { Gimei.name }
    end
    family_name { person.first.kanji }
    first_name { person.last.kanji }
    family_name_kana { person.first.katakana }
    first_name_kana { person.last.katakana }
    birthday { Faker::Date.backward }
  end
end

FactoryGirl.define do
  factory :shop do
    user
    name            { Faker::Name.title }
    address         { Faker::Name.first_name }
    telephone       { Faker::Number.number(10) }
    mobile_phones   { Faker::Number.number(6) }

    # after(:create){ |shop| shop.scategory_shops.create(:scategory) }
  end

  factory :another_shop, class: Shop do
    user
    name            { Faker::Name.title }
    address         { Faker::Name.first_name }
    telephone       { Faker::Number.number(10) }
    mobile_phones   { Faker::Number.number(6) }

    # after(:create){ |shop| shop.scategory_shops.create(:scategory) }
  end
end
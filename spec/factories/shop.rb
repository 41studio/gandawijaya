FactoryGirl.define do
  factory :shop do
    user
    name            { Faker::Name.first_name }
    address         { Faker::Name.first_name }
    telephone       { Faker::Number.number(10) }
    mobile_phones   { Faker::Number.number(6) }
    business_name   { Faker::Internet.url }
    business_email  { Faker::Internet.free_email }
    # after(:create){ |shop| shop.scategory_shops.create(:scategory) }
  end

  factory :another_shop, class: Shop do
    user
    name            { Faker::Name.first_name }
    address         { Faker::Name.first_name }
    telephone       { Faker::Number.number(10) }
    mobile_phones   { Faker::Number.number(6) }
    business_name   { Faker::Internet.url }
    business_email  { Faker::Internet.free_email }

    # after(:create){ |shop| shop.scategory_shops.create(:scategory) }
  end
end
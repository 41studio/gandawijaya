  FactoryGirl.define do

  factory :product do
    shop
    user
    name          { Faker::Name.first_name }
    price         { Faker::Number.number(rand(1..6)) }
    description   { Faker::Lorem.paragraph }
  end

end
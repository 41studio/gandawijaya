FactoryGirl.define do

  password = Faker::Internet.password

  factory :user do
    username              { Faker::Name.first_name }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              { password }
    password_confirmation { password }
    handphone             { Faker::Number.number(10) }
    address               { Faker::Lorem.sentence(3) }

    after(:create){ |user| user.confirm! }
  end

  factory :another_user, class: User do
    username              { Faker::Name.first_name }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              { password }
    password_confirmation { password }
    address               { Faker::Lorem.sentence(3) }
    handphone             { Faker::Number.number(10) }

    after(:create){ |user| user.confirm! }
  end

end
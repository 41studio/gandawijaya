FactoryGirl.define do

  password = Faker::Internet.password

  factory :user do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              { password }
    password_confirmation { password }

    after(:create){ |user| user.confirm! }
  end

  factory :another_user, class: User do
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    email                 { Faker::Internet.free_email }
    password              { password }
    password_confirmation { password }

    after(:create){ |user| user.confirm! }
  end

end
FactoryGirl.define do

  factory :offer do
    user
    offer_room
    content     { Faker::Lorem.paragraph }
  end

end
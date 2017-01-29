FactoryGirl.define do
  factory :room do
    name { Faker::Hipster.sentence(2) }
  end
end

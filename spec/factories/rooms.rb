FactoryGirl.define do
  factory :room do
    name { Faker::Hipster.word }
  end
end

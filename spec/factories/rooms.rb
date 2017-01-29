FactoryGirl.define do
  factory :room do
    name { Faker::Hipster.sentence(2) }
    user nil
  end
end

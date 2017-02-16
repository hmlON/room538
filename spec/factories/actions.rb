FactoryGirl.define do
  factory :action do
    sequence(:name) { |n| Faker::Hacker.ingverb + n.to_s }
  end
end

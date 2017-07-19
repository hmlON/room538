FactoryGirl.define do
  factory :room_activity do
    sequence(:name) { |n| Faker::Hacker.ingverb + n.to_s }
    room
  end
end

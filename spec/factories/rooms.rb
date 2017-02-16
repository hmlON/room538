FactoryGirl.define do
  factory :room do
    name { Faker::Hipster.word }

    after :build do |room|
      room.actions << create_list(:action, 3)
      room.users << create(:user)
    end

    factory :room_with_users do
      after :build do |room|
        room.users << create_list(:user, 3)
      end
    end
  end
end

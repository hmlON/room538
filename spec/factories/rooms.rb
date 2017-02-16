FactoryGirl.define do
  factory :room do
    name { Faker::Hipster.word }

    after :build do |room|
      room.actions << create_list(:action, 3)
      create(:user).join_room(room)
    end

    factory :room_with_users do
      after :build do |room|
        3.times { create(:user).join_room(room) }
      end
    end
  end
end

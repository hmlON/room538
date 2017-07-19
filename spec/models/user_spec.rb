RSpec.describe User, type: :model do
  let(:user) { create :user }
  let(:room) { create :room }
  subject { user }

  describe '#next_on_room_activities' do
    let(:another_user) { create :user, room: room }
    let(:room_activity_with_less_activities) { create :room_activity, room: room }
    let(:room_activity_with_more_activities) { create :room_activity, room: room }
    let!(:less_activities_1) { create_list(:activity, 1, room_activity: room_activity_with_less_activities, user: user) }
    let!(:less_activities_2) { create_list(:activity, 2, room_activity: room_activity_with_less_activities, user: another_user) }
    let!(:more_activities_1) { create_list(:activity, 2, room_activity: room_activity_with_more_activities, user: user) }
    let!(:more_activities_2) { create_list(:activity, 1, room_activity: room_activity_with_more_activities, user: another_user) }

    before { room.users << user }

    it 'returns room activities which he completed least times compared to his roommates' do
      expect(subject.next_on_room_activities.to_a).to eq [room_activity_with_less_activities]
    end
  end

  describe '#room?' do
    it 'returns true when user has room' do
      room.users << subject

      expect(subject.room?).to eq true
    end

    it 'returns false when user has no room' do
      expect(subject.room?).to eq false
    end
  end

  describe '#name' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#email' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end

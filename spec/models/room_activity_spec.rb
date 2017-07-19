RSpec.describe RoomActivity, type: :model do
  let(:room) { create :room }
  let(:room_activity) { create :room_activity, room: room }
  subject { room_activity }

  describe '#min_value' do
    let(:user) { create :user, room: room }
    let(:another_user) { create :user, room: room }
    let!(:activities) { create_list(:activity, 1, room_activity: subject, user: user) }
    let!(:another_activities) { create_list(:activity, 2, room_activity: subject, user: another_user) }

    it 'returns minimum from all user activities values' do
      expect(subject.min_value).to eq 1
    end
  end

  describe '#max_value' do
    let(:user) { create :user, room: room }
    let(:another_user) { create :user, room: room }
    let!(:activities) { create_list(:activity, 1, room_activity: subject, user: user) }
    let!(:another_activities) { create_list(:activity, 2, room_activity: subject, user: another_user) }

    it 'returns maximum from all user activities values' do
      expect(subject.max_value).to eq 2
    end
  end

  describe '#next_on_user' do
    let(:user) { create :user, room: room }
    let(:another_user) { create :user, room: room }
    let!(:activities) { create_list(:activity, 1, room_activity: subject, user: user) }
    let!(:another_activities) { create_list(:activity, 2, room_activity: subject, user: another_user) }

    it 'returns user who should do activity next' do
      expect(subject.next_on_user).to eq user
    end
  end
end

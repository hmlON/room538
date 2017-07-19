RSpec.describe UserActivity, type: :model do
  let(:room) { create :room }
  let(:user) { create :user, room: room }
  let(:room_activity) { create :room_activity, room: room }
  subject { UserActivity.new(user: user, room_activity: room_activity) }

  describe '#activities' do
    let(:activities) { create_list(:activity, 5, room_activity: room_activity, user: user) }
    let(:another_room_activity) { create :room_activity, room: room }
    let(:another_activities) { create_list(:activity, 5, room_activity: another_room_activity, user: user) }

    it 'returns array of activities done by user with room activities configuration' do
      expect(subject.activities).to eq activities
    end
  end # describe '#activities'

  describe '#value' do
    context 'when there are activities' do
      let!(:activities) { create_list(:activity, 5, room_activity: room_activity, user: user) }

      it 'returns count of completed activities' do
        expect(subject.value).to eq 5
      end
    end

    context 'when there are no activities' do
      it 'returns count of completed activities' do
        expect(subject.value).to eq 0
      end
    end
  end # describe '#value'
end

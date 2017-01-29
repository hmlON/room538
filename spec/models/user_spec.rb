RSpec.describe User, type: :model do
  subject { create(:user) }

  describe '#room?' do
    it 'returns true when user has room' do
      room = create(:room)
      room.users << subject

      expect(subject.room?).to eq true
    end

    it 'returns false when user has no room' do
      subject.room = nil

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

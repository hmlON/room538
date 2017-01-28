RSpec.describe User, type: :model do
  describe '#name' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#email' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe '#password' do
    it { is_expected.to validate_presence_of :password }
  end
end

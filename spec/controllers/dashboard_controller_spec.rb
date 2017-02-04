RSpec.describe DashboardController, type: :controller do
  include Devise::Test::ControllerHelpers

  context 'when user signed in' do
    let(:user) { create(:user) }
    before(:each) do
      sign_in user
      room = create(:room)
      room.users << user
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end

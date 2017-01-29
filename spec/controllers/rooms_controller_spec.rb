RSpec.describe RoomsController, type: :controller do
  include Devise::Test::ControllerHelpers

  context 'when user signed in' do
    let(:user) { create(:user) }
    before(:each) do
      sign_in user
    end

    describe 'GET #index' do
      it 'returns http success' do
        create_list(:room, 5, users: create_list(:user, 4))

        get :index

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(assigns(:rooms).length).to eq 5
      end
    end
  end
end

RSpec.feature 'Dashboard' do
  let(:user) { create(:user) }
  let(:room) { create(:room) }

  background do
    user.join_room(room)
    sign_in user
    visit dashboard_path
  end

  scenario 'User submits done action' do
    room_action = room.room_actions.first

    expect {
      select room_action.name, from: 'user_action_id'
      click_button 'Submit'
    }.to change { user.user_actions.where(action_id: room_action.action_id).first.value }.by(1)

    expect(page).to have_content 'Good job'
    expect(room_action.next_on_user).not_to eq user
  end
end

RSpec.feature 'Room requests' do
  let(:user) { create(:user) }
  let!(:room) { create(:room) }
  let(:room_user) { create(:user, room: room) }

  background do
    sign_in user
    visit rooms_path
  end

  scenario 'User joins room' do
    within "#room-#{room.id}" do
      click_on 'Send request to join'
    end
    expect(page).to have_content 'Request successfully sent'

    sign_in room_user
    click_link 'Invites'
    click_button 'Accept'

    expect(page).to have_content "#{user.name} successfully joined your room"
    expect(user.reload.room).to eq room
  end
end

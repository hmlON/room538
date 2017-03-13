RSpec.feature 'Room requests' do
  let(:user) { create(:user) }
  let(:room) { create(:room) }

  background do
    sign_in user
  end

  scenario 'User joins room' do
    room_user = room.users.first

    visit rooms_path
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

RSpec.feature 'Rooms' do
  let(:user) { create(:user) }
  let(:room) { create(:room, :with_old_setup) }

  background do
    sign_in user
    visit root_path
  end

  scenario 'User creates new room' do
    click_link 'Create new room'

    action = build :action
    click_button 'Create new action'
    within 'form#new_new_action' do
      fill_in 'Name', with: action.name
      click_button 'Create action'
    end

    fill_in 'Name', with: 'My room'
    check action.name
    click_button 'Create room'

    expect(page).to have_content 'You have successfully created new room "My room".'
    expect(page).to have_content user.name
    expect(page).to have_content "Next on #{action.name}"
  end

  scenario 'User updates room' do
    user.join_room(room)
    new_action = create(:action, creator: user)
    visit dashboard_path
    click_link 'Room settings'

    fill_in 'Name', with: 'New room name'
    uncheck room.actions.first.name
    check new_action.name
    click_button 'Update room'

    expect(page).to have_content 'You have successfully updated your room.'
    room.reload
    expect(room.name).to eq 'New room name'
    expect(room.actions).to include(new_action)
  end

  scenario 'User leaves room' do
    user = room.users.first
    sign_in user
    visit dashboard_path
    click_link 'Room settings'

    click_button 'Leave room'
    within '#leaveRoomModal' do
      click_on 'Leave room'
    end

    user.reload
    expect(user.room).to be_nil
    expect(Room.where(id: room.id)).to be_empty
  end

  scenario 'User looks at all rooms' do
    rooms = create_list(:room, 3)

    within '.page-wrapper' do
      click_link 'All rooms'
    end

    rooms.each do |room|
      expect(page).to have_content room.name
      room.users.each do |user|
        expect(page).to have_content user.name
      end
    end
  end
end

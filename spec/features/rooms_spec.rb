RSpec.feature 'Rooms' do
  let(:user) { create(:user) }

  background do
    sign_in user
    visit root_path
  end

  scenario 'User creates new room' do
    click_link 'Create new room'

    fill_in 'Name', with: 'My room'
    click_button 'Create room'

    expect(page).to have_content 'You have successfully created new room "My room".'
  end

  scenario 'User looks at all rooms' do
    rooms = create_list(:room, 3, users: create_list(:user, 3))

    click_link 'All rooms'

    rooms.each do |room|
      expect(page).to have_content room.name
      room.users.each do |user|
        expect(page).to have_content user.name
      end
    end
  end
end

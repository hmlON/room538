RSpec.feature 'Rooms' do
  let(:user) { create(:user) }

  scenario 'User creates new room' do
    sign_in user
    visit root_path
    click_link 'Create new room'

    fill_in 'Name', with: 'My room'
    click_on 'Create room'

    expect(page).to have_content 'You successfully created new room "My room"'
  end
end

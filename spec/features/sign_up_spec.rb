RSpec.feature 'Sign up' do
  scenario 'User signs up' do
    visit root_path
    click_link 'Sign up'

    fill_in 'Name', with: 'My Name'
    fill_in 'Email', with: 'my@name.com'
    fill_in 'Password', with: 'mypassword'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

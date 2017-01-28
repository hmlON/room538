RSpec.feature 'Sign in' do
  let(:user) { create :user }

  scenario 'User signs in' do
    visit root_path
    click_link 'Sign in'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
  end
end

RSpec.feature 'Sign out' do
  let(:user) { create :user }

  scenario 'User signs out' do
    sign_in create(:user)
    visit root_path

    click_link 'Sign out'

    expect(page).to have_content 'Signed out successfully'
  end
end

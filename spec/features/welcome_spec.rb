RSpec.feature 'Greetings message' do
  scenario 'User visits site' do
    visit '/'

    expect(page).to have_content('Welcome')
  end
end

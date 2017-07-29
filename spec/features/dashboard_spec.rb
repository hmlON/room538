RSpec.feature 'Dashboard' do
  let(:room) { create(:room, :with_activities) }
  let(:user) { room.users.first }
  let!(:room_activity) { create :room_activity, room: room }
  let(:room_activity_name) { room_activity.name }
  let(:undone_activity) { user.activities.last }

  background do
    sign_in user
    visit dashboard_path
  end

  scenario 'User submits done activity' do
    expect {
      select room_activity_name, from: 'activity_room_activity_id'
      click_button 'Submit'
    }.to change { Activity.count }.by(1)

    expect(page).to have_content 'Good job'
    expect(user.reload.next_on_room_activities.pluck(:name)).not_to include(room_activity_name)

    click_on 'History'
    within '#history' do
      expect(page).to have_content "#{user.name} has done \"#{room_activity.name}\""
    end
  end

  scenario 'User undoes activity' do
    click_on 'History'

    expect {
      within ".activity_#{undone_activity.id}" do
        click_button 'Undo'
      end
    }.to change { Activity.count }.by(-1)
  end
end

# User is a preson, who lives in a room
#
# == Schema Information
#
# Table name: room_requests
#
#  id                   :integer    not null, primary key
#  created_at           :datetime
#  updated_at           :datetime
#  name                 :string     DEFAULT(''), not null
#  email                :string     DEFAULT(''), not null
#  encrypted_password   :string     DEFAULT(''), not null
#  room_id              :integer
#  provider             :string
#  uid                  :string
#  photo_url            :string
#
class User < ApplicationRecord
  belongs_to :room, optional: true
  has_many :activities
  has_many :sent_room_requests, class_name: 'RoomRequest', foreign_key: 'sender_id'

  default_scope { order(:id) }

  delegate :room_activities, to: :room

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :vkontakte]

  validates :name, presence: true

  def next_on_room_activities
    room_activities.select { |room_activity| room_activity.next_on_user == self }
  end

  def leave_room
    activities.destroy_all
    update(room: nil)
  end

  def room?
    room_id != nil
  end

  # method for omniauth
  def self.new_with_session(params, session)
    super.tap do |user|
      data = session['devise.vkontakte_data']
      if data && data['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end

# User is a preson, who lives in a hostel room
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

  # :reek:DuplicateMethodCall { allow_calls: ['auth.info', 'auth.provider', 'auth.uid'] }
  def self.from_omniauth(auth)
    if where(email: auth.info.email).exists?
      user = find_by(email: auth.info.email)
      user.update(provider: auth.provider, uid: auth.uid, photo_url: auth.info.image)
      user.remember_me!
      return user
    end

    create(email: auth.info.email, name: auth.info.name,
           password: Devise.friendly_token[0, 20],
           provider: auth.provider, uid: auth.uid,
           photo_url: auth.info.image)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      data = session['devise.vkontakte_data']
      if data && data['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end
end

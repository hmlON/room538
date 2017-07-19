# User is a preson, who lives in a hostel room
class User < ApplicationRecord
  belongs_to :room, optional: true
  has_many :activities
  has_many :user_actions
  has_many :sent_room_requests, class_name: 'RoomRequest', foreign_key: 'sender_id'
  has_many :created_actions, class_name: 'Action', foreign_key: 'creator_id'

  default_scope { order(:id) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :vkontakte]

  validates :name, presence: true

  def join_room(room)
    room.users << self
    room.room_actions.each do |room_action|
      user_actions.create(room_action: room_action)
    end
    sent_room_requests.destroy_all
  end

  def leave_room
    user_actions.destroy_all
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

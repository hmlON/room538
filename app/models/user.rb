# User is a preson, who lives in a hostel room
# User is a preson, who lives in a hostel room
class User < ApplicationRecord
  belongs_to :room, optional: true
  has_many :user_actions
  alias actions user_actions
  has_many :sent_room_requests, class_name: 'RoomRequest', foreign_key: 'sender_id'
  has_many :created_actions, class_name: 'Action', foreign_key: 'creator_id'

  default_scope { order(:id) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte]

  validates :name, presence: true

  def join_room(room)
    room.users << self
    room.actions.each do |action|
      actions << UserAction.create(action: action)
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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      info = auth['info']
      user.email = info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = info.name
      # user.image = info.image # assuming the user model has an image
    end
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

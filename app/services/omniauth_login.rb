# OmniauthLogin finds user by auth or creates new
class OmniauthLogin < ApplicationService
  attr_reader :user

  # :reek:DuplicateMethodCall { allow_calls: ['auth.info'] }
  def initialize(auth)
    @params = {}
    params[:email] = auth.info.email
    params[:name] = auth.info.name
    params[:photo_url] = auth.info.image
    params[:provider] = auth.provider
    params[:uid] = auth.uid
  end

  def perform
    @user = find_user_by_email || create_new_user
  end

  private

  attr_reader :params

  def find_user_by_email
    user = User.find_by(email: params[:email])
    return unless user
    user.update(params.select { |key, _| [:provider, :uid, :photo_url].include? key })
    user.remember_me!
    user
  end

  def create_new_user
    User.create(params.merge(password: Devise.friendly_token[0, 20]))
  end
end

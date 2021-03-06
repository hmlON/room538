module Users
  # Controller for omniauth logins
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def vkontakte
      auth = request.env['omniauth.auth']
      @user = OmniauthLogin.perform(auth).user
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'VK') if is_navigational_format?
      else
        session['devise.vkontake_data'] = auth
        redirect_to new_user_registration_url
      end
    end

    def google_oauth2
      auth = request.env['omniauth.auth']
      @user = OmniauthLogin.perform(auth).user
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        session['devise.google_data'] = auth
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end

# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
   # def facebook
   #   callback_for(:facebook)
   # end
   #
   #  def twitter
   #    callback_for(:twitter)
   #  end

 #  def google_oauth2
 #    callback_for(:google)
 #  end
 #
 #  def callback_for(provider)
 #    @user = User.from_omniauth(request.env["omniauth.auth"])
 #    if @user.persisted?
 #      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
 #      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
 #    else
 #      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
 #      redirect_to new_user_registration_url
 #    end
  # end


  def facebook
   # You need to implement the method below in your model (e.g. app/models/user.rb)
   @user = User.from_omniauth(request.env["omniauth.auth"])

   if @user.persisted?
     sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
   else
     session["devise.facebook_data"] = request.env["omniauth.auth"]
     redirect_to new_user_registration_url
   end
 end


 def google
    @user = User.find_for_google(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
      session[:user_id] = @user.id #add
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end



  def failure
   redirect_to root_path
  end
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end

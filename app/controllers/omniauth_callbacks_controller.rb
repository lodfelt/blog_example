class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    omniauth = request.env["omniauth.auth"]
    user = User.from_omniauth(omniauth)
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
    expire_fragment "navigation"
  end
  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :google_oauth2, :all
end


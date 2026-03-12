class Users::GithubCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :github

  def github
    @user = User.from_omniauth

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["device.github_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_usr_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

class Users::GithubCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_session_path, alert: "GitHubログインに失敗しました"
    end
  end

  def failure
    redirect_to root_path, alert: "GitHubログインをキャンセルしました"
  end
end

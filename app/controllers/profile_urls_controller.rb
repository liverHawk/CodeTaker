class ProfileUrlsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_url_params)
      redirect_to root_path, notice: "URLを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_url_params
    params.require(:user).permit(:url)
  end
end

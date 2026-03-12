class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :desc)
  end

  def confirm
    user = User.find(params[:id])
    user.update!(confirmed: true)
    redirect_to admin_users_path, notice: "#{user.email} を confirm にしました"
  end
end


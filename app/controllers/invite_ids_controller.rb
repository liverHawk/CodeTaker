class InviteIdsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_confirmed!, only: :create

  def show
    @invite_id = flash[:invite_id]
    @error = flash[:invite_error]
    @already_assigned = InviteId.exists?(user_id: current_user.id)
    @confirmed = current_user.confirmed?
  end

  def create
    result = InviteIds::Redeem.call(user: current_user)

    case result.status
    when :already_assigned
      flash[:invite_error] = "You have already redeemed your invite id"
    when :none_available_invite_ids
      flash[:invite_error] = "You have no unused invite ids available"
    else
      flash[:invite_id] = result.code
    end

    redirect_to invite_ids_path
  end

  private

  def require_confirmed!
    return if current_user.confirmed?

    flash[:invite_error] = "Please confirm your account before revealing an invite id"
    redirect_to invite_ids_path
  end
end

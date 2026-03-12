class InviteIdsController < ApplicationController
  before_action :authenticate_user!

  def show
    result = InviteIds::Redeem.call(user: current_user)

    case result.status
    when :already_redeemed
      @error = "You have already redeemed your invite id"
    when :none_available_invite_ids
      @error = "You have no unused invite ids available"
    else
      @invite_id = result.code
    end
  end
end

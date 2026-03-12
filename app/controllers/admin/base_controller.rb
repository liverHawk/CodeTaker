class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  private

  def require_admin!
    emails = Array(Rails.application.credentials.dig(:admin, :emails))
    allowed = emails.include?(current_user.email)

    unless allowed
      render plain: "Forbidden", status: :forbidden
    end
  end
end


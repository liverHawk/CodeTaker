module InviteIds
  class Redeem
    Result = Struct.new(:success?, :status, :code, :error, keyword_init: true)

    def self.call(user:)
      new(user:).call
    end

    def initialize(user:)
      @user = user
    end

    def call
      already = InviteId.lock.find_by(user: @user)
      return Result.new(success?: false, status: :already_redeemed, error: "Already redeemed") if already

      invite = InviteId.lock.unused.find_by(user: @user)
      return Result.new(success?: false, status: :none_available_invite_ids, error: "No unused invite ids available") unless invite

      invite.update!(used: true, user: @user)
      Result.new(success?: true, status: :success, code: invite.invite_id, error: nil)
    end
  end
end

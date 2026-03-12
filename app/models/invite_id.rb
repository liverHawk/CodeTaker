class InviteId < ApplicationRecord
  belongs_to :user, optional: true

  validates :invite_id, presence: true, uniqueness: true
  validates :invite_id, format: { with: /\A[a-zA-Z0-9]{8}\z/ }

  def self.unused
    where(used: false)
  end
end

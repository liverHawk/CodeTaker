class InviteId < ApplicationRecord
  belongs_to :user

  validates :invite_id, presence: true, uniqueness: true

  def self.unused
    where(used: false)
  end
end

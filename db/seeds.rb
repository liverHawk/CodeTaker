# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Demo inventory for one-time invite IDs.
# Keeps a small pool of unassigned, unused codes for local development/demo.
if defined?(InviteId)
  target_pool_size = 20
  current_pool_size = InviteId.unused.where(user_id: nil).count

  (target_pool_size - current_pool_size).times do
    code = nil
    10.times do
      candidate = SecureRandom.alphanumeric(8)
      next if InviteId.exists?(invite_id: candidate)
      code = candidate
      break
    end

    next unless code
    InviteId.create!(invite_id: code, used: false, user_id: nil)
  end
end

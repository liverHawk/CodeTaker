# db/seeds.rb
require "csv"

# InviteId を CSV から読み込み
csv_path = Rails.root.join("db", "seeds", "invite_ids.csv")
if defined?(InviteId) && File.exist?(csv_path)
  CSV.foreach(csv_path, headers: true) do |row|
    code = row["invite_id"].to_s.strip
    next if code.blank?

    InviteId.find_or_create_by!(invite_id: code) do |invite|
      invite.used = false
      invite.user_id = nil
    end
  end
end

# 既存のデモ生成は必要なら残す

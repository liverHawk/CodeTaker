class User < ApplicationRecord
  has_one :invite_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    provider = auth.try(:provider) || auth[:provider] || auth["provider"]
    uid = auth.try(:uid) || auth[:uid] || auth["uid"]
    info = auth.try(:info) || auth[:info] || auth["info"] || {}
    email = info.try(:email) || info[:email] || info["email"]
    name = info.try(:name) || info[:name] || info["name"] || info.try(:nickname) || info[:nickname] || info["nickname"]

    if provider.present? && uid.present?
      user = find_by(provider: provider, uid: uid)
      return user if user
    end

    user = email.present? ? find_by(email: email) : nil

    if user
      user.update!(provider: provider, uid: uid, name: user.name.presence || name)
      return user
    end

    create!(
      email: email.presence || "#{uid}@#{provider}.oauth.local",
      password: Devise.friendly_token[0, 20],
      provider: provider,
      uid: uid,
      name: name,
    )
  end
end

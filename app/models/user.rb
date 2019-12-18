class User < ApplicationRecord
  before_destroy :check_all_events_finished

  has_many :events, dependent: :destroy
  has_many :tickets, dependent: :nullify
  has_many :join_events, through: :tickets, source: :event

  def self.find_or_create_from_auth(auth)
    email = auth[:info][:email]
    provider = auth[:provider]
    uid = auth[:uid]
    icon = auth[:info][:image]
    oauth_token = auth[:credentials][:token]
    case provider
    when "twitter" then
      name = auth[:info][:name]
    end

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.email = email
      user.name = name
      user.icon = icon
      user.provider = provider
      user.uid = uid
      user.oauth_token = oauth_token
    end
  end

  private

    def check_all_events_finished
      now = Time.zone.now
      if events.where(':now < end_time', now: now).exists?
        errors[:base] << "公開中の未終了イベントが存在します。"
      end

      if join_events.where(':now < end_time', now: now).exists?
        errors[:base] << "参加予定の未終了イベントが存在します。"
      end
      errors.blank?
    end
end

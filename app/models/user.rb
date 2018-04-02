class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, authentication_keys: [:username]
  devise :registerable, :recoverable, :rememberable, :trackable
  devise :omniauthable, omniauth_providers: %i[github]

  has_many :roles

  validates :username, presence: true, uniqueness: true
  # validates :password, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :name, presence: true, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def is_admin?
    self.roles.any?{|role| role.admin}
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.nickname
      user.name = auth.info.name
      user.email = auth.info.email if auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end

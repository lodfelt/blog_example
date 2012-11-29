class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :title, :body, :first_name, :last_name, :username, :avatar, :profile_attributes, :provider, :uid
  has_and_belongs_to_many :roles
  before_create :assign_role
  after_create :associate_with_profile
  has_many :articles
  has_one :profile
  mount_uploader :avatar, AvatarUploader
  accepts_nested_attributes_for :profile
  validates_uniqueness_of :email

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  def name
    name = "#{first_name} #{last_name}".strip
    return "" if name.blank?
    name
  end

  def associate_with_profile
    self.profile = Profile.new unless self.profile
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  private
  def assign_role
    if self.role_ids.empty?
      self.role_ids = [2]
    end
  end
end

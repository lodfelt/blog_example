class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [ :login ]

  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :title, :body, :first_name, :last_name, :username, :avatar, :profile_attributes, :provider, :uid, :role
  after_create :associate_with_profile
  after_create :assign_role
  after_create :release_cache
  has_many :articles
  has_one :profile
  mount_uploader :avatar, AvatarUploader
  accepts_nested_attributes_for :profile
  validates_uniqueness_of :email
  attr_accessor :login  # Virtual accessor that allows Devise authenticate on both username and email


  ROLES = %w[admin author]

  def name
    name = "#{first_name} #{last_name}".strip
    name = username if name.blank?
    return "" if name.blank?
    name
  end

  def login
    username || email
  end

  def self.find_first_by_auth_conditions(orig_conditions)
    conditions = orig_conditions.dup

    if login = conditions.delete(:login)
      where(conditions).where([
        "lower(username) = :value OR lower(email) = :value",
        { value: login.downcase }
      ]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      if auth.provider == "twitter"
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.nickname
        user.avatar = auth.info.image
      elsif auth.provider == "facebook"
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.nickname
        user.email = auth.info.email
        # user.remote_avatar_url  = auth.info.image image provided by facebook is really small and does not look good when cropped
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
      elsif auth.provider = "google_oauth2"
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
      end
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
    if self.role.blank?
      self.role = "author"
    end
  end

  def associate_with_profile
    self.profile = Profile.new unless self.profile
  end

  def release_cache
    ActionController::Base.new.expire_fragment('navigation')
  end
end

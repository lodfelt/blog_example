class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  attr_accessible :email, :password, :password_confirmation, :remember_me, :title, :body, :first_name, :last_name
  has_and_belongs_to_many :roles
  before_create :assign_role
  has_many :articles

  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  private
  def assign_role
    if self.role_ids.empty?
      self.role_ids = [2]
    end
  end
end

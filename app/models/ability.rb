class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
      can :publish, Article
    elsif user.role? :member
       can :read, :all
       can :create, [Article, Comment]
       can [:edit, :update], Comment
    end
  end
end
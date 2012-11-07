class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    elsif user.role? :member
      can :read, :all
      can [:create, :delete], [Article, Comment]
      can [:edit, :update], Comment
      can :publish, Article
    else
      #User is a visitor
      can :read, :all
      can :create, Comment
    end
  end
end

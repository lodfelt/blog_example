class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
      can :access, :admin
    elsif user.role? :member
      can :read, :all
      can [:create, :edit, :update, :delete], [Article, Comment]
      can [:edit, :update], Comment
      can :publish, Article
      can :delete, Tag
    else
      #User is a visitor
      can :read, Article
      can :read, Comment
      can :read, Tag
      can :create, Comment
    end
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
      can :access, :admin
    elsif user.role? :member
      can :read, :all
      can [:create, :edit, :update, :destroy], [Article, Comment]
      can [:edit, :update], Comment
      can :publish, Article
      can :destroy, Tag
      can :read, User
      can :update, User do |user_to_update|
        user == user_to_update
      end
      can [:create, :destroy], ArticleImage
    else
      #User is a visitor
      can :read, Article
      can :read, Comment
      can :read, Tag
      can :read, ArticleImage
      can :read, User
      can :create, Comment
    end
  end
end

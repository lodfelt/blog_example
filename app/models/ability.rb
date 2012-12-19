class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == 'admin'
      can :manage, :all
      can :access, :admin
    elsif user.role == 'author'
      can :read, :all
      can [:create, :edit, :update, :destroy], [Article, Comment]
      can :destroy, Tag
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

class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
      can :access, :admin
    else
      #can :read, :all
      can :manage, Comment, :user_id => user.id
      can :manage, Post,    :user_id => user.id
      can :manage, Story,   :user_id => user.id
      can :manage, User,    :id      => user.id
    end

    # everyone can post comments
    can :create, Comment
  end
end

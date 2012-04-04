class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :manage, Comment, :user_id => user.id
      can :manage, Post,    :user_id => user.id
      can :manage, Story,   :user_id => user.id
    end
  end
end

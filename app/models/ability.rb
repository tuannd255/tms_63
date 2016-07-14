class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if user.admin?
      can :manage, User
      if namespace == "supervisor"
        cannot :manage, :all
      end
    elsif user.supervisor?
      if namespace == "admin"
        cannot :manage, :all
      end
    else
      if namespace == "supervisor"
        cannot :manage, :all
      elsif namespace == "admin"
        cannot :manage, :all
      end
    end
  end
end

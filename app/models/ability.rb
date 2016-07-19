class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if user.admin?
      can :manage, [User, Subject, Course]
      if namespace == "supervisor"
        cannot :manage, :all
      end
    elsif user.supervisor?
      can [:add, :destroy], UserCourse
      can [:read], Course
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

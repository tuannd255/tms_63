class Ability
  include CanCan::Ability

  def initialize user, namespace
    user ||= User.new
    if user.admin?
      can :manage, [User, Subject, Course]
      can [:add, :destroy], UserCourse
      if namespace == "supervisor"
        cannot :manage, :all
      end
    elsif user.supervisor?
      can [:add, :destroy, :read], UserCourse
      can :read, User
      can [:read, :update], [Course, CourseSubject, UserSubject]
      if namespace == "admin"
        cannot :manage, :all
      end
    else
      can [:read], [UserCourse, User, UserSubject]
      can [:create], UserTask
      can :update, UserSubject
      if namespace == "supervisor"
        cannot :manage, :all
      elsif namespace == "admin"
        cannot :manage, :all
      end
    end
  end
end

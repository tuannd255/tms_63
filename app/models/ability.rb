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
      can [:add, :destroy], UserCourse
      can [:read, :update], [Course, CourseSubject]
      if namespace == "admin"
        cannot :manage, :all
      end
    else
      can [:read], Course
      can [:read, :update], UserTask
      if namespace == "supervisor"
        cannot :manage, :all
      elsif namespace == "admin"
        cannot :manage, :all
      end
    end
  end
end

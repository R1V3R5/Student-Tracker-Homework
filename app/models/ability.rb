class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      # can :manage, :all
      can :read, Location
      can :read, Course, id: user.courses.map(&:id)
      can :read, Assignment, :user_id => user.id
      can :read, Submission, id: user.submissions.map(&:id)
      can :create, Submission, :user_id => user.id
      can :update, Submission, :user_id => user.id
      can :read, Comment, :user_id => user.id
    end
  end
end


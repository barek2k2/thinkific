class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    unless user.new_record?
      can :manage, Course, user_id: user.id
      can :manage, Chapter, course: { user_id: user.id }
      can :manage, Content, chapter: { course: { user_id: user.id } }
    else
      # guest user
    end
  end
end



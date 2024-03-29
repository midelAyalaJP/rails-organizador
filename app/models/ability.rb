# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md



    can :manage, Task, owner_id: user.id
    can :read, Task, participating_users: {user_id: user.id}

    can :create, Note, task: {owner_id: user.id}

    # * si el usuario es propietario del post puede escribir notas
    # can :create, Note do |n|
    #     # obtener el propietario de la tarea
    #     owner_id = Task.find(n.task_id).owner_id
    #     # obtener el pid del current user
    #     user_id = user.id
    #     # comparo si el current user es propietario de la tarea
    #     owner_id == user_id
    # end
  end
end

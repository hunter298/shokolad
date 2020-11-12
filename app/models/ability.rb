# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user
  attr_accessor :cookies

  def initialize(user)
    @user = user
    @cookies = {}

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :read, Cart, user_id: user.id
  end

  def guest_abilities
    can :read, :all
    cannot :read, Cart do |cart|
      cart.cookies != @cookies[:cart]
    end
    can :create, CartItem
    can :create, Order
  end
end

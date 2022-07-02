class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :public_recipes, Recipe
    can :read, Recipe, public: true
    return unless user.id

    can :manage, Recipe, user: user
    can :manage, Food, user: user
    can :manage, RecipeFood, recipe: { user_id: user.id }
  end
end

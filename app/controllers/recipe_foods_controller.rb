class RecipeFoodsController < ApplicationController

  def shopping_list
    @recipe = Recipe.find(params[:recipe_id])
    @foods = @recipe.foods
  end

  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(params[:recipe_food][:food_id])
    @recipe_food = RecipeFood.new(recipe_params)
    @food.update(quantity: params[:recipe_food][:quantity])
    @recipe_food.recipe = @recipe
    @recipe_food.food = @food
    respond_to do |format|
      if @recipe_food.save
        @recipe.update(total_price: @recipe.total_price + (@food.price * @food.quantity))
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe Food added successfully.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(params[:food_id])
    @recipe_food = RecipeFood.find_by(recipe_id: params[:recipe_id], food_id: params[:food_id])
    puts @recipe_food.id
    @recipe_food.destroy
    @recipe.update(total_price: @recipe.total_price - (@food.price * @food.quantity))
    respond_to do |format|
      format.html { redirect_to recipe_url(id: params[:recipe_id]), notice: 'Recipe Food was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def recipe_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end

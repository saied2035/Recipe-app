class RecipesController < ApplicationController
  load_and_authorize_resource
  before_action :order, only: %i[public_recipes index]
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def public_recipes
    @recipes = Recipe.where('public = true').order(order)
  end

  def index
    return unless current_user.present?

    @current_user = current_user
    puts "what is that! #{@current_user.name}"
    @recipes = @current_user.recipes.order(order)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.includes(:foods).find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    render :edit, status: :unprocessable_entity unless @recipe.update(public: !@recipe.public)
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :description, :prepration_time, :cooking_time)
  end

  def order
    'created_at DESC'
  end
end

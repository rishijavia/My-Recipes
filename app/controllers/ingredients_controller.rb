class IngredientsController < ApplicationController
  before_action :require_user, except: [:show]

  
  def show
    @ingredient = Ingredient.find(params[:id])
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(params_ingredient)
    if @ingredient.save
      flash[:success] = "Ingredient created successfully"
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  private
  
    def params_ingredient
      params.require(:ingredient).permit(:name)
    end
  
end
class RecipesController < ApplicationController
    before_action :find_recipe, only: [:show, :update, :destroy]
    
    def index
        if params["name"]
            @recipes = Recipe.where("name LIKE ?","%#{params["name"]}%")
        else
            @recipes = Recipe.all
        end
        render json: @recipes, include: [:users]
    end

    def show
        render json: @recipe, include: [:users]
    end
    
    def create
        Recipe.create(
            name: params[:name],
            ingredient: params[:ingredient],
            instructions: params[:instructions]
        )
        redirect_to "http://localhost:3001/"
    end

    def update 
        @recipe.update(
            name: params[:name],
            ingredient: params[:ingredient],
            instructions: params[:instructions]
        )
        redirect_to "http://localhost:3001/showRecipe.html?id=#{@recipe.id}"
    end

    def destroy
        @recipe.destroy
        redirect_to "http://localhost:3001"
    end

    private

    def find_recipe
        @recipe = Recipe.find(params[:id])
    end

    def allowed_params
        params.permit(:name,)
    end
end

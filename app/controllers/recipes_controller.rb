class RecipesController < ApplicationController
    def index
        user = User.find_by(id: session[:user_id])
        if user
            render json: user.recipes, include: :user
        else
            render json: {errors: ["Unauthorized"]}, status: :unauthorized
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = user.recipes.create(recipe_params)
            if recipe.valid?
                render json: recipe, include: :user, status: :created
            else
                render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render json: {errors: ["Unauthorized"]}, status: :unauthorized
            
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end



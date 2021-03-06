class UsersController < ApplicationController
    
    skip_before_action :authorize, only: :create

    def create 
        user = User.create!(user_params)
        session[:user_id] = user.id 
        render json: user, status: :created
    end

    def index
        render json: User.all
    end

    def show
        render json: @current_user 
    end

    def update
        @current_user.update!(user_params)
        render json: @current_user, status: :ok
    end

    def destroy
        user = @current_user
        user.destroy
        head :no_content
    end


    private
    
    def user_params 
        params.permit(:first_name, :last_name, :username, :password, :password_confirmation)
    end
end
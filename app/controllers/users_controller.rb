class UsersController < ApplicationController
  def show
    if(params[:id] == 'current')
      render json: current_user
    else
      render json: User[params[:id]]
    end
  end

  def new
    render json: User.new
  end
end

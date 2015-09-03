class UsersController < ApplicationController
  def show
    render json: User[params[:id]]
  end

  def new
    render json: User.new
  end
end

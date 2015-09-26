class CardsController < ApplicationController
  def index
    render json: CardQuery.new({}, current_user).query()
  end

  def show
    render json: CardQuery.new(params, current_user).query.where(id: [params[:id]]).first
  end

  def create
    render json: Card.create(number: (Card.max(:number) || 0) + 1)
  end
end

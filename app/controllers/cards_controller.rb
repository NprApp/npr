class CardsController < ApplicationController
  def index
    render json: CardQuery.new.query
  end

  def show
    render json: Card[params[:id]]
  end

  def create
    render json: Card.create(number: (Card.max(:number) || 0) + 1)
  end
end

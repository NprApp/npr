class CardsController < ApplicationController
  expose :cards

  def index
    render json: cards
  end

  def show
    render json: Card[params[:id]]
  end

  def create
    sleep 1
    render json: Card.create(params[:card])
  end
end

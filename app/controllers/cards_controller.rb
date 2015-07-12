class CardsController < ApplicationController
  expose :cards
  expose :card

  def index
    render json: cards
  end

  def show
    render json: card
  end

  def create
    sleep 1
    render json: Card.create(params[:card])
  end
end

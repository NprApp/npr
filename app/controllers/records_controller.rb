class RecordsController < ApplicationController
  def index
    render json: Record.where(card_id: params[:card_id])
  end
end

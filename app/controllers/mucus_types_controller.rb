class MucusTypesController < ApplicationController
  def index
    render json: MucusType.all
  end
  def create
    type = MucusType.create params[:mucus_type]
    render json: type
  end
  def update
    render json: MucusType[params[:id]].update params[:mucus_type]
  end
  def destroy
    render json: MucusType[params[:id]].destroy
  end
end

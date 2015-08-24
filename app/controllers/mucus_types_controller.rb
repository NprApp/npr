class MucusTypesController < ApplicationController
  def index
    render json: MucusType.all
  end
  def create
    type = MucusType.create parsed_params
    render json: type
  end
  def show
    render json: MucusType[params[:id]]
  end
  def update
    render json: MucusType[params[:id]].update(parsed_params)
  end
  def destroy
    render json: MucusType[params[:id]].destroy
  end
  def parsed_params
    params[:mucus_type].select {|k, v| param_attributes.map(&:to_s).include? k}
  end
  def param_attributes
    [:symbol, :peak_type, :fertile]
  end
end

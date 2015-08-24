class RecordTypesController < ApplicationController
  def index
    render json: RecordType.all
  end
  def show
    render json: RecordType[params[:id]]
  end
  def create
    type = RecordType.create parsed_params
    render json: type
  end
  def update
    render json: RecordType[params[:id]].update(parsed_params)
  end
  def destroy
    render json: RecordType[params[:id]].destroy
  end
  def parsed_params
    params[:record_type].select {|k, v| param_attributes.map(&:to_s).include? k}
  end
  def param_attributes
    [:name, :code]
  end
end

class RecordTypesController < ApplicationController
  def index
    render json: RecordType.all
  end
  def create
    type = RecordType.create params[:record_type]
    render json: type
  end
  def update
    render json: RecordType[params[:id]].update params[:record_type]
  end
  def destroy
    render json: RecordType[params[:id]].destroy
  end
end

class RecordsController < ApplicationController
  def index
    render json: RecordQuery.new(params).query
  end
  def create
    record = Record.create parsed_params
    render json: RecordQuery.new(id: record.id).query.first
  end
  def update
    record = Record[params[:id]].update(parsed_params)
    render json: RecordQuery.new(id: record.id).query.first
  end
  def destroy
    render json: Record[params[:id]].destroy
  end
  def parsed_params
    params[:record].select {|k, v| param_attributes.map(&:to_s).include? k}
  end
  def param_attributes
    [:card_id, :date, :type_id, :bleeding_type, :peak_day, :mucus_type_id, :frequency, :details]
  end
end

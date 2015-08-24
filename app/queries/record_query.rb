class RecordQuery
  def initialize(params = {})
    @params = params
  end
  def query
    dataset = Record
      .select_all(:records)
      .order(Sequel.asc(:records__date))
    if @params[:card_id].present?
      dataset = dataset.where(records__card_id: @params[:card_id])
    end
    if @params[:id].present?
      dataset = dataset.where(records__id: @params[:id])
    end
    dataset
  end
  def min_max
    Record.select(Sequel.function(:min, :date).as(:min_date), Sequel.function(:max, :date).as(:max_date), :card_id).group(:card_id)
  end
end

class RecordQuery
  def initialize(params = {})
    @params = params
  end
  def query
    Record
      .select_all(:records)
      .select_append(Sequel.lit("row_to_json(mt)").as(:mucus_type), Sequel.lit("row_to_json(t)").as(:type))
      .where(card_id: @params[:card_id])
      .left_join(:mucus_types___mt, mt__id: :records__mucus_type_id)
      .left_join(:record_types___t, t__id: :records__type_id)
  end
  def min_max
    Record.select(Sequel.function(:min, :date).as(:min_date), Sequel.function(:max, :date).as(:max_date), :card_id).group(:card_id)
  end
end

class CardQuery
  def initialize(params, user)
    @params = params
    @user = user
  end
  def query
    Card.
      select_all(:cards).
      select_append(:dates__min_date, :dates__max_date).
      left_join(RecordQuery.new.min_max.as(:dates), dates__card_id: :cards__id).
      where(cards__user_id: @user.id).
      order(:number)
  end
end

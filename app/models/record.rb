class Record < Sequel::Model
  many_to_one :type, class: "RecordType", key: :type_id
  many_to_one :mucus_type

  def validate
    super
    # r_date = date
    # if CardQuery.new.query.where{(min_date < r_date) & (max_date < r_date)}
    #   errors.add :card_id, "date_from_another_card"
    # end
    #
    # if Record.where(date: date).exclude(id: id)
    #   errors.add :date, "duplicated_date"
    # end
  end
end

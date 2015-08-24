class Card < Sequel::Model
  one_to_many :records
  def validate
    super
    errors.add(:number, "cannot_be_empty") unless number
  end
end

class Card < Sequel::Model
  one_to_many :records
  many_to_one :user
  def validate
    super
    errors.add(:number, "cannot_be_empty") unless number
  end
end

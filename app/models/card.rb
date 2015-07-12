class Card < Sequel::Model
  one_to_many :records
end

class RecordType < Sequel::Model
  one_to_many :records, key: :type_id
end

class Record < Sequel::Model
  many_to_one :type, class: "RecordType", key: :type_id
  many_to_one :mucus_type
end

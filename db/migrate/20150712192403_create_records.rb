Sequel.migration do
  change do

    create_table :record_types do
      primary_key :id
      String :name, null: false, unique: true
      String :code, null: false, uniqie: true
    end

    create_table :mucus_types do
      primary_key :id
      String :symbol, null: false
      TrueClass :fortile, null: false, default: false
      TrueClass :peak_type, null: false, default: false
    end

    create_table :records do
      primary_key :id
      foreign_key :card_id, :cards, null: false
      Date :date, null: false
      foreign_key :type_id, :record_types, null: false
      String :bleeding_type
      Integer :peak_day
      foreign_key :mucus_type_id, :mucus_types
      Integer :frequency
    end

  end
end

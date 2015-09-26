Sequel.migration do
  up do
    alter_table :records do
      set_column_type :peak_day, TrueClass, using: 'case when peak_day = 0 then true else false end'
    end
  end

  down do
    alter_table :records do
      set_column_type :peak_day, Integer, using: 'case when peak_day then 1 else 0 end'
    end
  end
end

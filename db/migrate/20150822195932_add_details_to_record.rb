Sequel.migration do
  change do
    alter_table :records do
      add_column :details, String
    end
  end
end

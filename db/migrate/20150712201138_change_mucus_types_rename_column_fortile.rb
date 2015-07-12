Sequel.migration do
  up do
    alter_table :mucus_types do
      rename_column :fortile, :fertile
    end
  end

  down do
    alter_table :mucus_types do
      rename_column :fertile, :fortile
    end
  end
end

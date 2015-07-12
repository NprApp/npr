Sequel.migration do
  change do

    create_table :cards do
      primary_key :id
      Integer :number
    end

  end
end

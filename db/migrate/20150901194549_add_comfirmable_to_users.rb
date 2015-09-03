Sequel.migration do
  change do
    add_column :users, :confirmation_token, String, unique: true
    add_column :users, :confirmed_at, Time
    add_column :users, :confirmation_sent_at, Time
    execute('UPDATE users SET confirmed_at = NOW()')
  end
end

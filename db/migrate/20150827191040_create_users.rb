Sequel.migration do
  change do

    create_table :users do
      primary_key :id
      String :email, null: false, unique: true
      String :encrypted_password, default: '', null: false
      String :reset_password_token
      Time :reset_password_sent_at
      Time :remember_created_at
      Integer :sign_in_count, default: 0, null: false
      Time :current_sign_in_at
      Time :last_sign_in_at
      String :current_sign_in_ip
      String :last_sign_in_ip
      String :authentication_token
      TrueClass :is_admin, default: false, null: false
    end

  end
end

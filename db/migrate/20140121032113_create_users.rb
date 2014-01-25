class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :remember_token
      t.timestamps
    end

    add_index :users, :email,           unique: true
    add_index :users, :phone_number,    unique: true
    add_index :users, :remember_token,  unique: true
  end
end

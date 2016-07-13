class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.integer :gender
      t.string :password_digest
      t.boolean :supervisor

      t.timestamps null: false
    end
  end
end

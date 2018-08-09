class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.boolean :administrator
      t.string :phonenumber
      t.boolean :mfa_enabled

      t.timestamps
    end
  end
end

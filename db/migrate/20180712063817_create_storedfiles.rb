class CreateStoredfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :storedfiles do |t|
      t.string :name
      t.binary :path
      t.references :user

      t.timestamps
    end
  end
end

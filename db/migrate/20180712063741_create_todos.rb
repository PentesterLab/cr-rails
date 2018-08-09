class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :data
      t.references :user

      t.timestamps
    end
  end
end

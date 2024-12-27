class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :line_user_id, null: false
      t.string :name, null: false
      t.date :birthday

      t.timestamps
    end
  end
end

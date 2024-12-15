class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :line_user_id, null: false, unique: true
      t.string :name, null: null
      t.date :birthday

      t.timestamps
    end
  end
end

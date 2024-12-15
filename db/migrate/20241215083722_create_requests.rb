class CreateRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :requests do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end

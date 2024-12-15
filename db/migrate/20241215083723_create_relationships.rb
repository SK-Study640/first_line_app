class CreateRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :relationships do |t|
      t.integer :user_id, null: false
      t.integer :partner_id, null: false

      t.timestamps
    end

    # 外部キー制約（自己参照）
    add_foreign_key :relationships, :users, column: :user_id
    add_foreign_key :relationships, :users, column: :partner_id
  end
end

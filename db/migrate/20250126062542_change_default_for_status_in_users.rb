class ChangeDefaultForStatusInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :status, from: "pending", to: "unset"
  end
end

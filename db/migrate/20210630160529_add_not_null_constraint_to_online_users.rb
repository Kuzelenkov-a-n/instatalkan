class AddNotNullConstraintToOnlineUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :online, false
  end
end

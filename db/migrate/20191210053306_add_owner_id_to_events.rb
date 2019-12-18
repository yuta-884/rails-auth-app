class AddOwnerIdToEvents < ActiveRecord::Migration[5.2]
  def up
    add_reference :events, :owner, foreign_key: { to_table: :users }
  end
  def down
    remove_reference :events, :owner, foreign_key: { to_table: :users }
  end
end

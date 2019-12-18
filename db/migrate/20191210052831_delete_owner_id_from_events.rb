class DeleteOwnerIdFromEvents < ActiveRecord::Migration[5.2]
  def up
    remove_column :events, :owner_id
  end

  def down
    add_column :events, :owner_id, :integer
  end
end

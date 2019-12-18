class RemoveOwnerIdFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_reference :events, :owner, foreign_key: true
  end
end

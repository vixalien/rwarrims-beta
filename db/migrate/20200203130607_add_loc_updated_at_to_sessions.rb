class AddLocUpdatedAtToSessions < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :loc_updated_at, :datetime
  end
end

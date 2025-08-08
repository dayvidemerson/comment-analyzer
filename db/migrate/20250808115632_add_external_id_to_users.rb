class AddExternalIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :external_id, :string
  end
end

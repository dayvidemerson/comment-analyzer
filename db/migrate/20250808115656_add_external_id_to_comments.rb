class AddExternalIdToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :external_id, :string
  end
end

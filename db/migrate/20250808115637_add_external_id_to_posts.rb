class AddExternalIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :external_id, :string
  end
end

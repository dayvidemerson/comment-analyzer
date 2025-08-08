class AddTranslatedNameToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :translated_name, :string
  end
end

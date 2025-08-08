class CreateImporters < ActiveRecord::Migration[8.0]
  def change
    create_table :importers do |t|
      t.string :type
      t.integer :state
      t.string :key

      t.timestamps
    end
  end
end

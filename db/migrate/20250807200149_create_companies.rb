class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :catch_phrase
      t.string :bs

      t.timestamps
    end
  end
end

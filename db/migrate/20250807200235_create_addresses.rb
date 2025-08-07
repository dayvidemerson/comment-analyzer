class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :suite
      t.string :city
      t.string :zipcode
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end

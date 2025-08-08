class AddRatingToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :rating, :integer
  end
end

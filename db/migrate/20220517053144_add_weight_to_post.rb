class AddWeightToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :weight, :float
    add_index :posts, :weight
  end
end

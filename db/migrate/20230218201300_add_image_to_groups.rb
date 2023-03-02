class AddImageToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :image, :binary
  end
end

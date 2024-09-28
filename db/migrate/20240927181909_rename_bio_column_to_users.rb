class RenameBioColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :bio, :biography
  end
end

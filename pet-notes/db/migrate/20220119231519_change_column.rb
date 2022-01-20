class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :pets, :type, :breed
  end
end

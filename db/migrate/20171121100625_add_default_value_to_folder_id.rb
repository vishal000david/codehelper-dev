class AddDefaultValueToFolderId < ActiveRecord::Migration[5.1]
  def change
  	change_column :stores ,:folder_id ,:integer, :default => nil

  end
end

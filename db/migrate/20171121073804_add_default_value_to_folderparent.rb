class AddDefaultValueToFolderparent < ActiveRecord::Migration[5.1]
  def change
  	change_column :folders, :folderParent, :string, :default => "FileManager"
  end
end

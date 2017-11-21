class AddSubfolderIdToStore < ActiveRecord::Migration[5.1]
  def change
  	add_column :stores ,:folder_id,:integer
  end
end

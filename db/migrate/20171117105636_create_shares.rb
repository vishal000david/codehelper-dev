class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.integer :reciever_id
      t.integer :store_id
      t.string :permission

      t.timestamps
    end
  end
end

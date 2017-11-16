class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
    	t.string  :memberType,null: false
      t.integer :totalQuota, null: false,:limit => 11 

      t.timestamps
    end
  end
end

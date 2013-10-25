class CreateWorkItems < ActiveRecord::Migration
  def change
    create_table :work_items do |t|
      t.string :name
      t.text :description
      t.integer :sale_id

      t.timestamps
    end
  end
end

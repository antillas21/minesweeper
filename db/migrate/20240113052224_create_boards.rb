class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.string :created_by, null: false
      t.integer :width, null: false, default: 1
      t.integer :height, null: false, default: 1
      t.integer :mines_count, null: false, default: 1
      t.text :layout, array: true, default: [], limit: 16777215
      t.timestamps
    end
  end
end

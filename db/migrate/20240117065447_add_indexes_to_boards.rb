class AddIndexesToBoards < ActiveRecord::Migration[7.1]
  def change
    add_index :boards, :name, unique: true
    add_index :boards, :created_by
    add_index :boards, :mines_count
  end
end

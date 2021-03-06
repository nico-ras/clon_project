class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.integer :friend_id
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

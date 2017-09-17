class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :query
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :searches, [:user_id, :created_at]
  end
end

class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.integer :user_id
      t.string :name
      t.string :url
      t.timestamps
    end
  end
end

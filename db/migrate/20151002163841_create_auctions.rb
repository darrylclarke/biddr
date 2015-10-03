class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.datetime :end_date_time
      t.integer :reserve_price
      t.integer :aasm_state

      t.timestamps null: false
    end
  end
end

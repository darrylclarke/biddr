class ChangeAasmStateInAuctionToString < ActiveRecord::Migration
  def change
  change_column :auctions, :aasm_state,  :string
  end
end

class CreateThirdPartyTxns < ActiveRecord::Migration
  def self.up
    create_table :third_party_txns do |t|
      t.references :payment
      t.string :identifier
      t.decimal :amount, :precision => 8, :scale => 2
      t.decimal :fee, :precision => 8, :scale => 2
      t.string :currency_type
      t.string :status
      #t.datetime :received_at
      t.timestamps
    end
  end

  def self.down
    drop_table :third_party_txns
  end
end

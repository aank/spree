class CreateThirdPartyPayments < ActiveRecord::Migration
  def self.up
    change_table :payments do |t|
      t.string :email
      t.string :payer_id
    end
  end

  def self.down
    change_table :payments do |t|
      t.remove :email
      t.remove :payer_id
    end    
  end
end

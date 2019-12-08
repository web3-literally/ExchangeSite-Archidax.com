class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :member_id
      t.string :currency_id
      t.decimal :amount, precision: 32, scale: 16, default: 0.0
      t.decimal :usd_amount, precision: 32, scale: 16, default: 0.0
      t.string :ref_type
      t.integer :trade_id
      t.integer :from_member_id

      t.datetime :created_at, null: false
    end

    add_index :rewards, :member_id
    add_index :rewards, :ref_type
  end
end

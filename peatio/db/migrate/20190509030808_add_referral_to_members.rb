class AddReferralToMembers < ActiveRecord::Migration
  def change
    add_column :members, :ref_member_id, :integer
    add_column :members, :zero_fee, :boolean, null: false, default: false
    add_column :members, :house_fee, :boolean, null: false, default: false
    add_column :members, :code, :string

    add_index :members, :code, unique: true
    add_index :members, :zero_fee
    add_index :members, :house_fee
    add_index :members, :ref_member_id
  end
end
